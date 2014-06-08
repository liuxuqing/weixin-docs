ruxpin.is-programmer.com/posts/39118.html

Live a manga life

But doctor, he says. I am Pagliacci
activeadmin0.6.0+rails3.2.13在用thin或nginx+passenger跑生产模式时i18n无效的情况
扩展activeadmin的datepicker功能，以及中文布局错误的解决方法
以微信公众平台接口网站为例探讨在ruby中去掉case..when..判断的一些方法
rux posted @ about 1 year ago in ruby with tags ruby rails , 972 readers

  很多条件判断，给人的第一感觉是，嗯，这里要用case..when..了，我个人是很不喜欢用case..when..的，它往往伴随着长串的不易管理的代码，在判断条件增加时会显得杂乱无章，而且很难看。下面的例子来自我用rails搭建的微信公共账号的公众平台接口网站，主要从如何根据微信的内容返回相关的信息来讲述避免使用case..when..判断的一些方法，不涉及如何搭建微信公众帐号接口网站，如果你需要这方面的信息，请参看万神劫写的用Rails搭建微信公众平台 API。

1、用判断的条件动态创建相应的类来处理。

 首先，接收到信息的controller，假设为WechatController，那么它的create方法就是处理接受信息并给出返回的啦，刚开始时你可能会这样写
?
wechat_controller.rb
1
2
3
4
5
6
7
8
9
10
11
12
13
14
	
def create   
    case params[:xml][:MsgType]
    when "text"
      @return_content = WechatTextHandler.new(params[:xml]).return
      render "text", :formats => :xml
    when "event"
      @return_content = WechatEventHandler.new(params[:xml]).return
      render "event", :formats => :xml
    when "xxx"
     .
     .
     .
    end
end

  这里WechatTextHandler和WechatEventHandler分别是你用来处理text信息和event信息的类，ok,这里已经不少when了，而且随着MsgType的增加，你还要不断的增加when判断代码。用ruby，你可以不这么写。我们注意到这些用来处理的类名和when的判断条件有所关联，譬如处理"text"的就是WechatTextHandler,而render的模板名称也叫"text"(事实上这些类名及模板是我故意命名成如此的)，那么我们可以根据params[:xml][:MsgType]的值来构建相应的类并处理就可以了。
?
wechat_controller.rb
1
2
3
4
	
def create
  @return_content = Object.const_get("Wechat#{params[:xml][:MsgType].capitalize}Handler").new(params[:xml]).return
  render params[:xml][:MsgType], :formats => :xml
end

Object.const_get("Xxx")会返回一个Xxx类(Object的子类，如果父类是其它如FatherClass，则用FathClass.const_get("Xxx"))，所以在这里我们直接用params[:xml][:MsgType]构建了对应的处理类，volia！case..when..不见了，而且以后有新的MsgType时，譬如"click", 你不需要再去动controller里的代码，只需要写好处理click信息的类WechatClickHandler就可以了，它会自动构建WechatClickHandler类然后用params[:xml]参数实例化并调用return方法返回处理后的返回信息。

这个方法需要你规划好自己的类名。

2、使用对应的条件->方法hash来调用方法。

   我们以WechatTextHandler为例讲如何不用case..when..判断来响应用户发来的命令信息。

   譬如说我们的微信公共账号有三个功能，分别是：

    查联系人电话号码（格式为"电话 关键字"或"d 关键字"）,调用方法 query_phone

    查花名 （格式为"花 关键字"或"h 关键字"），调用方法 query_flower

    随机返回一个笑话  (格式为"笑话"或"j"), 调用方法 tell_a_joke

那么你的return_content方法很可能看起来是这样的：
?
wechat_text_handler.rb
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
	
# 假设你已经在initialize里把命令和关键字拆开并将命令赋值给了command变量
def return_content
  if valid_command? # 假设你有个valid_command?方法来检查命令的合法性
    case command
    when "电话"
      query_phone
    when "d"
      query_phone
    when "花"
      query_flower
    when "h"
      query_flower
    when "笑话"
      tell_a_joke
    when "j"
      tell_a_joke
    end
  end
end

天啊，才三个命令就已经写了这么多行了，而且以后要添加功能的话还得不停的加when判断，这...一点都不好看也不利于扩展对吧?

这种时候我们可以用一个hash来维护命令和要调用的方法之间的关系，并替换掉这些case..when..判断。
?
wechat_text_handler.rb
1
2
3
4
5
6
7
8
9
10
11
12
13
	
Commands = { "电话"   => { :method => :query_phone},
             "q"      => { :method => :query_phone},
             "花"     => { :method => :query_flower},
             "h"      => { :method => :query_flower},
             "笑话"   => { :method => :tell_a_joke},
             "j"      => { :method => :tell_a_joke}
            }
 
def return_content
  if valid_command?
    send Commands[command][:method]
  end
end

volia!只剩下一条语句，case..when..没有了！send("xmethod")将会调用xmethod这个方法，在这里我们就是在hash里找到命令对应的方法并调用，就是这么简单，而且你的valid_command?方法只需要
?
wechat_text_handler.rb
1
2
3
	
def valid_command? 
  Comamnds.has_key? command
end

就可以实现了。以后添加功能也不需要你再去修改return_content方法的代码，只需要写好要调用的方法，并把命令和调用方法的关系加入hash中就可以了，逻辑对应关系也是一目了然，这不是很好吗？ 甚至这个hash你也可以修改一下结构放到其他地方（譬如数据库中）。

以上的两种方法只是提供了一些思路，我相信还会有更多更好的方法，希望大家一起探讨。
Small_feed Comments (0)

    ruxpin
    Avatar
    exhausted
    Categories
        diary
        ruby
        cloudfoundry
        unkown
    New Comments
    New Messages
    Links
    Meta
        Register
        Login
        Forgot password ?
        Posts RSS
        Comments RSS
        Messages RSS

Apricot theme designed by Ardamis.com. XHTML, CSS. Host by is-Programmer.com | Power by Chito 1.3.3 beta

Entries (RSS) and Comments (RSS) and Messages (RSS)

