<?php
##class WechatResponse {}
#55#abstract 
abstract class WechatResponse { ####回复的基本消息
	protected $toUserName;
	protected $fromUserName;
	protected $funcFlag;
	public function __construct($toUserName, $fromUserName, $funcFlag) {
	$this->toUserName = $toUserName;
	$this->fromUserName = $fromUserName;
	$this->funcFlag = $funcFlag;
	}
	abstract public function __toString();
}
###
#######no abstract ##### $ch = new WechatResponse("GuangZhou","ShunliChan","WeChat");
############ print_r($ch);

class TextResponse extends WechatResponse {####回复的文本消息 ##"class TextResponse < WechatResponse "  ##基本验证（继承WechatResponse）加上XML的$template
    protected $content;
#    protected $template = <<<XML   ####for function __toString
    protected $template = <<<XML
<xml>
<ToUserName><![CDATA[%s]]></ToUserName>
<FromUserName><![CDATA[%s]]></FromUserName>
<CreateTime>%s</CreateTime>
<MsgType><![CDATA[text]]></MsgType>
<Content><![CDATA[%s]]></Content>
<FuncFlag>%s<FuncFlag>
</xml>
XML;
    public function __construct($toUserName, $fromUserName, $content, $funcFlag = 0) {
      parent::__construct($toUserName, $fromUserName, $funcFlag);
      $this->content = $content;
    }
    public function __toString() {
      return sprintf(###1111##$this->template,
        $this->toUserName,
        $this->fromUserName,
        time(),
        $this->content,
        $this->funcFlag
      );
    }
  }
$ch = new TextResponse("GuangZhou","ShunliChan","WeChat");  ##TextResponse Object([template:protected] => <xml>...</xml>)
print_r($ch);
##ok##=>   TextResponse Object
##ok##=>   (
##ok##=>       [content:protected] => WeChat
##ok##=>       [template:protected] => <xml>
##ok##=>   <ToUserName><![CDATA[%s]]></ToUserName>
##ok##=>   <FromUserName><![CDATA[%s]]></FromUserName>
##ok##=>   <CreateTime>%s</CreateTime>
##ok##=>   <MsgType><![CDATA[text]]></MsgType>
##ok##=>   <Content><![CDATA[%s]]></Content>
##ok##=>   <FuncFlag>%s<FuncFlag>
##ok##=>   </xml>
##ok##=>       [toUserName:protected] => GuangZhou
##ok##=>       [fromUserName:protected] => ShunliChan
##ok##=>       [funcFlag:protected] => 0
##ok##=>   )




?>
