class Post
  ####skip_before_filter :verify_authenticity_token
  ##222####before_filter :check_weixin_legality

  def show
    render :text => params[:echostr]  ### 验证URL有效性: echostr 随机字符串 若确认此次GET请求来自微信服务器，请原样返回echostr参数内容，则接入生效

  end

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end

  private
  # 根据参数校验请求是否合法，如果非法返回错误页面
  def check_weixin_legality
    array = [Rails.configuration.weixin_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end

