chaoskeh.com/blog/create-weixin-api-by-rails.html
https://github.com/edokeh/bajiao-weixin/blob/master/config/initializers/weixin_router.rb

万神劫

万物天地为剑，神鬼妖邪为剑
劫波万渡，宇宙苍穹尽为剑
是为万神劫！

    Blog
    Archives
    About

47条评论 2013-02-17
用 Rails 搭建微信公众平台 API
Ruby or Rails rails 微信 公众平台API

最近微信很火，春节在家抽空研究了公众平台的 API ，发现挺有意思的，写篇小文，简单记录一下
微信 API 简介

先来看看 API 的工作流程和机制
微信公众平台的账户可以开启“开发模式”（在“高级功能”中），开启之后，用户发送微信到你的账户时，将有如下流程

用户向公众平台账号发送微信后，微信服务器会将一段 XML 以 HTTP POST 请求的方式发送给你的 API 服务器
API 服务器经过处理后，通过 HTTP 响应将另一段 XML 返回给微信服务器，这时候用户会收到来自你的公众平台帐号的回复

那么，两个服务器之间如何互相验证身份呢？
在开启开发模式时，除了要填写 API 服务器的 URL，还要填写一个 token 值
填写完毕后，微信服务器会发送一个 GET 请求给 URL ，附带一些参数，你可以根据 token 与参数校验合法性，合法时需要根据要求返回一个字符串，这样微信服务器才会确认你的 API 服务器的身份
以后每次微信服务器 POST 请求时，都会带上这些参数，你可以以同样的方式来判断对方的合法性

具体的细节，可以参照官方文档 http://mp.weixin.qq.com/wiki/index.php
XML 传输格式之类细节的本文就不再赘述了，文档上说的很详细。假如你已经大致了解这些内容，那么可以进入下一节
搭建服务

根据以上的原理，我们的服务需要提供两个 HTTP 接口，一个用于初始化时验证，另一个用来收发消息
新建一个 Rails 工程，然后创建一个 Controller ，并配置 routes

class WeixinsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  def show
  end

  def create
  end
end

# routes.rb
resource :weixin

这里需要跳过验证 CSRF token 的 filter ，否则微信服务器 POST 过来的消息会被拦截掉
鉴于两个 action 都需要同样的验证逻辑，我们可以把验证的过程写在 filter 方法里

  before_filter :check_weixin_legality

  private
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

这里为了方便，将 token 写在了 Rails 的 config 配置里
然后根据文档的要求，补全第一个 action，返回参数上的 echostr

  def show
    render :text => params[:echostr]
  end

下面处理核心的收发消息 action
首先是接收，根据文档，微信服务器发送过来的是 XML ，幸运的是 Rails3 已经内置了相应的解析功能，非常方便
比如如果服务器 POST 发送以下的 XML

<xml>
 <ToUserName><![CDATA[toUser]]></ToUserName>
 <FromUserName><![CDATA[fromUser]]></FromUserName> 
 <CreateTime>1348831860</CreateTime>
 <MsgType><![CDATA[text]]></MsgType>
 <Content><![CDATA[this is a test]]></Content>
 <MsgId>1234567890123456</MsgId>
</xml>

在 Controller 中，可以直接使用 params 参数取值，跟处理表单提交参数一样，比如params[:xml][:MsgType] == "text"

那么发送 XML 格式的响应该怎么实现呢？最简单的方法，用不着乱七八糟的 XML 库，直接用 erb 就行了

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end

# echo.xml.erb
<xml>
    <ToUserName><![CDATA[<%= params[:xml][:FromUserName] %>]]></ToUserName>
    <FromUserName><![CDATA[<%= params[:xml][:ToUserName] %>]]></FromUserName>
    <CreateTime><%= Time.now.to_i %></CreateTime>
    <MsgType><![CDATA[text]]></MsgType>
    <Content><![CDATA[大山的回声：<%= params[:xml][:Content] %>]]></Content>
    <FuncFlag>0</FuncFlag>
</xml>

甚至可以引入 layout，因为除了 MsgType 和 Content 两个节点之外，其他部分基本都是固定的

OK，到这里，通过不足50行代码，我们已经成功搭建了一个简单的“回声”微信 API ，Rails 的快速、强大表现得淋漓极致！

以上的代码都托管在了https://github.com/edokeh/test-weixin ，有兴趣可以看看

最后，微信要求 API 必须部署在 80 端口，如果没有自己的服务器，推荐部署到国外免费的 PAAS 平台上
比如 CloudFoundry 就相当不错，空间免费，提供二级域名，只需要几行命令就可以将 Rails 程序发布上去
一些技巧和注意点
在文本消息中插入 QQ 表情 / 符号表情

比如下图

QQ 表情是通过 /:,@! 这样的形式来发送，资深的 QQ 用户应该都知道
符号表情其实是特殊的 UTF8 字符，比如 \u{1F389} 这个字符就是上图中的喇叭
关于符号表情，可以点这里了解 http://www.iapps.im/wp-content/uploads/2012/02/emoji-pinyin.png
下面就是上图中表情的代码

<Content><![CDATA[/:,@! /::)/::~<%= "\u{1F389}" %><%= "\u{1F47B}" %>]]></Content>

因为是写在 CDATA 中，所以没法用 &#x1F389 这样的形式直接写 UTF8 字符，只能通过 erb 来输出
新用户关注时自动回复

新用户关注你的公众帐号时，微信服务器会发一条特殊的文本信息给 API 服务器，内容为 “Hello2BizUser"
这样我们可以根据这条消息来回复相应的欢迎信息
FuncFlag 的作用

XML 回复中有一个 FuncFlag 节点，通过设置这个节点的内容，可以给微信消息加星标
比如用户如果发送一个请求，而 API 又无法处理，可以将这个节点内容设置为 1，那么用户发送的消息会被加上星标
这样以后在公众平台的后台就可以方便地找到这条消息
其他技巧

还有些技巧，参考我在社区发的这篇文章吧 http://ruby-china.org/topics/8988
« Jumper，网站帐号快速切换器 为什么 SeaJS 模块的合并这么麻烦 »
Copyright © 2014 - Chaos - Powered by Klog2


