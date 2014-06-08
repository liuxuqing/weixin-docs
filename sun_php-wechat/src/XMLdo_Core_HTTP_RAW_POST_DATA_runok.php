<?php
  class Wechat {  ##Controller
    private $debug;
    private $request; ##数组保存
##########All project __construct() ########### 
    private function isValid() {
      return isset($_GET['echostr']);
    }

    public function __construct($token, $debug = FALSE) {
      if ($this->isValid() && $this->validateSignature($token)) {
        exit($_GET['echostr']);
      }
      $this->debug = $debug;
#      set_error_handler(array(&$this, 'errorHandler')); set_error_handler（）预计参数（Wechat:: ERRORHANDLER）是一个有效的回调
      $template = <<<XML
<xml>
<ToUserName><![CDATA[%s]]></ToUserName>
<FromUserName><![CDATA[%s]]></FromUserName>
<CreateTime>%s</CreateTime>
<MsgType><![CDATA[text]]></MsgType>
<Content><![CDATA[%s]]></Content>
<FuncFlag>%s</FuncFlag>
</xml>
XML;
      $xml = (array) simplexml_load_string($template, 'SimpleXMLElement', LIBXML_NOCDATA);##php用http_raw_post_data来接收post过来的数据" $GLOBALS['HTTP_RAW_POST_DATA'] "  ~ $template(myxml) 
      $this->request = array_change_key_case($xml, CASE_LOWER);
    }

}
$ch = new Wechat("Wexin_token");
print_r($ch);

###=>    Wechat Object
###=>    (
###=>        [debug:Wechat:private] => 
###=>        [request:Wechat:private] => Array
###=>            (
###=>                [tousername] => %s
###=>                [fromusername] => %s
###=>                [createtime] => %s
###=>                [msgtype] => text
###=>                [content] => %s
###=>                [funcflag] => %s
###=>            )
###=>    
###=>    )


?>
