https://ruby-china.org/topics/8988

    首页
    社区
    Wiki
    招聘
    推文
    酷站

    0
    chanshunli

586
用 Rails 折腾微信 API 的一点小技巧
Rails · edokeh · 于1年前发布 · 最后由 ruby_sky 于3月前回复 · 4666次阅读

之前用 Rails 弄过微信 API，无比轻松，几十行代码就能搭建一个简单的接口
不过要折腾得大一点的时候，发现代码组织上会比较麻烦，比如接口要实现这样的功能：如果发送 @+字符串，返回消息A，如果发送图片，返回消息B，发送其他文本，返回消息C，这时候代码可能会这样

def create
    query_type = params[:xml][:MsgType]
    if query_type == "image"
        do_method_b
    elsif query_type == "text"
        query = params[:xml][:Content]
        if query.start_with? "@"
            do_method_a
        else
            do_method_c
        end
    end
end

可以看到大量的逻辑堆在一个方法里面，即便用子方法切开，看起来也很乱。如果能够像 route 一样，根据请求的不同，由不同的 Controller 来处理的话，代码会清晰很多。我翻了下 route 的 API，发现还真能这样做，constraints 参数可以根据 request 的不同来决定路由

  scope :path => "/weixin", :via => :post do
    root :to => 'weixin#method_a', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'image' }

    root :to => 'weixin#method_b', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' && request.params[:xml][:Content].start_with?('@') }

    root :to => 'weixin#method_c', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'text' }
  end

这样看上去就清晰多了，如果嫌后面的 lambda 还是太繁琐，可以用一个 class 再稍微封装一下，比如我现在封装后的代码是这样

  scope :path => "/weixin", :via => :post do
    root :to => 'weixin#method_a', :constraints => Weixin::Router.new(:type => "image")

    root :to => 'weixin#method_b', :constraints => Weixin::Router.new(:type => "text", :content => /^@/)

    root :to => 'weixin#method_c', :constraints => Weixin::Router.new(:type => "text")
  end

共同折腾微信 API 的同志们可以参考下
关注 26 人喜欢
共收到 23 条回复
1153
mobiwolf 1楼 · 1年前 喜欢

好经验分享，顶之！
77
HungYuHei 2楼 · 1年前 喜欢

才刚刚吐槽过微信竟然用 XML
586
edokeh 3楼 · 1年前 喜欢

#2楼 @HungYuHei
唉，是啊，XML 太繁琐，而且微信API目前也只是个半残品
4467
tarzansos 4楼 · 1年前 喜欢

微信现在有语音的接口吗？
586
edokeh 5楼 · 1年前 喜欢

#4楼 @tarzansos
还没有开放呢
2511
as181920 6楼 · 1年前 喜欢

1，完整的code有么，我看你在github上的没有新的路由的那部分。对

Weixin::Router.new(:type => "image")

这一段没懂哈；

2，rails 4似乎有说如下，是不是说4开始要加gem才能这么轻松处理接收的xml

Remove support for parsing XML parameters from request. If you still want to parse XML parameters, please install `actionpack-xml_parser' gem.

3，对于不同的请求type，可以在逻辑代码里面用send不同的方法来区分，和通过路由来区分各有啥优劣
2511
as181920 7楼 · 1年前 喜欢

class DemoWeixin::Router
  def initialize(type="text")
    @message_type = type
  end

  def matches?(request)
    xml_data = request.params[:xml]
    if xml_data and xml_data.is_a?(Hash)
      @message_type == request.params[:xml][:MsgType]
    end
  end
end

DemoWeixin::Application.routes.draw do

  get "welcome/index"

  get "message/io"   => "message#auth"
  #post "message/io"  => "message#talk"
  scope "/", via: :post do
    #match "message/io" => "message#reply_text", constraints: lambda {|request| request.params[:xml].nil? }
    #match "message/io" => "message#reply_image", constraints: lambda {|request| request.params[:xml] && request.params[:xml][:MsgType] == "text"}
    match "message/io" => "message#reply_text", constraints: DemoWeixin::Router.new("text")
    match "message/io" => "message#reply_image", constraints: DemoWeixin::Router.new("image")
    match "message/io" => "message#reply_location", constraints: DemoWeixin::Router.new("location")
    match "message/io" => "message#reply_link", constraints: DemoWeixin::Router.new("link")
    match "message/io" => "message#reply_event", constraints: DemoWeixin::Router.new("event")
    match "message/io" => "message#reply_music", constraints: DemoWeixin::Router.new("music")
    match "message/io" => "message#reply_news", constraints: DemoWeixin::Router.new("news")
    match "message/io" => "message#reply_news", constraints: lambda {|r| r.params}
  end

  root to: 'welcome#index'
end

https://github.com/as181920/demo_weixin
2511
as181920 8楼 · 1年前 喜欢

回复字数有限制，但是不知道具体是多少
586
edokeh 9楼 · 1年前 1 人喜欢

#6楼 @as181920
哦，那个我写在另外一个项目里面，可以看看这里https://github.com/edokeh/bajiao-weixin/blob/master/config/initializers/weixin_router.rb
这样做的好处嘛，一是可维护性更高，router 中的声明式代码肯定比普通命令式的代码更容易理解和修改
另外一点，如果用子方法的话，其实每个子方法并不是Rails 的 action 方法，这样使用上会有些局限，比如不能为其中的某个子方法单独加 filter
Rails4 不支持 XML 的POST了啊？我还没注意到，去看看先
A45c96489b5c940facf4883d469e77df
futer 10楼 · 1年前 喜欢

严重怀疑微信的内部api 肯定有更好的文档，可能可以用json传数据了
586
edokeh 11楼 · 1年前 喜欢

#10楼 @futer
我猜内部肯定有隐藏的机制，比如招行的微信账号，居然能一次回复两条
28936031e91c554c5255d939bd80350a
xiaoronglv 12楼 · 1年前 喜欢

相比node, 有啥优势?
2511
as181920 13楼 · 1年前 喜欢

没啥，如果会ruby开发成本低吧，如果会node那就node成本低吧，暂时这些也没有什么性能和安全的问题。
6130
xyf158 14楼 · 1年前 喜欢

学习了…………
12aa4043a5ece235c3a54f92b76e8ac0
reducm 15楼 · 9月前 喜欢

@edokeh 请教一下楼主，像例如我用招行信用卡做完一比交易，然后招行的公众号可以直接推一条交易内容的信息给我，请问这个推的接口是怎么调用的...微信文档里面找不到啊...
586
edokeh 16楼 · 9月前 喜欢

#15楼 @reducm
是的，主动推送不在官方接口里面，招行跟微信有内部合作，所有有更高级的接口
4b7885be74907b88028ba9b698996502
John_ 17楼 · 5月前 喜欢

#15楼 @reducm
#16楼 @edokeh

现在的服务号交钱就有一个客服接口了.

在用户推送消息给你之后, 你可以在24小时还是12小时内, 对他不断推信息.
F4353e2dbeee172f2ea27d6ebe87eef6
ruxpin 18楼 · 5月前 喜欢

我是用元编程处理这些代码的杂乱问题，写了有文章在这里: http://ruxpin.is-programmer.com/posts/39118.html
28936031e91c554c5255d939bd80350a
xiaoronglv 19楼 · 4月前 喜欢

看了一晚上，总算搞明白了 Rails route constraints

我资质太差了。
28936031e91c554c5255d939bd80350a
xiaoronglv 20楼 · 4月前 喜欢

请教楼主一个问题，为什么使用 root to，而不是

 post  ':username',  :to => 'weixin#method_a', :constraints => lambda { |request| request.params[:xml][:MsgType] == 'image' }

586
edokeh 21楼 · 4月前 喜欢

@xiaoronglv
因为上面有了 :via => :post 呗
12aa4043a5ece235c3a54f92b76e8ac0
reducm 22楼 · 3月前 喜欢

Rails4 remove了xml post。。。
http://my.oschina.net/wchen/blog/151476
https://github.com/rails/actionpack-xml_parser
273
ruby_sky 23楼 · 3月前 喜欢

https://github.com/lanrion/weixin_rails_middleware 这个好用。

    编辑
    预览


Ctrl+Enter

    支持 Markdown 格式, **粗体**、~~删除线~~、`单行代码`
    支持表情，见 Emoji cheat sheet
    按“M”键查看更多 帮助。

Rails
发布新帖
小贴士
回帖里面当“喜欢”的数量达到 5 人以上，此回帖将会以高亮显示。
节点下其他话题

    关于 rails 的跑脚本问题
    批量数据该怎么处理才能减少耗时
    rails 写的查询语句是否有缓冲
    like 模糊查询时的 syntax error

关于 | 活跃会员 | API | Mac 客户端 | 贡献者 | 帮助推广 | 反馈 | Github | Twitter

中国 Ruby 社区，由众多爱好者共同维护，致力于构建完善的 Ruby 中文社区。
图片存储由 又拍云存储 提供。


