# -*- encoding : utf-8 -*-
class WeixinsController < ApplicationController  ## rails g controller weixin

  skip_before_filter :verify_authenticity_token  ####echo 1##这里需要跳过验证 CSRF token 的 filter ，否则微信服务器 POST 过来的消息会被拦截掉
  ###!!!!##before_filter :check_weixin_legality ##echo 2 鉴于两个 action 都需要同样的验证逻辑，我们可以把验证的过程写在 filter 方法里   ####first do filter !

  def show  ###echo 1
    render :text => params[:echostr]  ###echo 4 然后根据文档的要求，补全第一个 action，返回参数上的 echostr
  end

  def create  ### echo 1
    if params[:xml][:MsgType] == "text"  ##echo 5 在 Controller 中，可以直接使用 params 参数取值，跟处理表单提交参数一样
      render "echo", :formats => :xml  ##echo 6 那么发送 XML 格式的响应该怎么实现呢？最简单的方法，用不着乱七八糟的 XML 库，直接用 erb 就行了
    end
  end

  private  ###echo 2
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort ###Rails.configuration.weixin_token  => "echotest" #######comparison of String with nil failed (ArgumentError in WeixinsController#show )
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end

end
