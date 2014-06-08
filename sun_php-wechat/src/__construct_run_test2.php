<?php
  class Wechat {  ##Controller
    private $debug;
    private $request; ##数组保存
##########All project __construct() ########### 
    public function __construct($token, $debug = FALSE) {
      if ($this->isValid() && $this->validateSignature($token)) {
        exit($_GET['echostr']);
      }
      $this->debug = $debug;
      set_error_handler(array(&$this, 'errorHandler'));
      $xml = (array) simplexml_load_string($GLOBALS['HTTP_RAW_POST_DATA'], 'SimpleXMLElement', LIBXML_NOCDATA);
      $this->request = array_change_key_case($xml, CASE_LOWER);
    }
###############zhubei for goujian __construct()#####
    private function isValid() {
      return isset($_GET['echostr']);
    }
    private function validateSignature($token) {
      $signature = $_GET['signature'];
      $timestamp = $_GET['timestamp'];
      $nonce = $_GET['nonce'];
      $signatureArray = array($token, $timestamp, $nonce);
      sort($signatureArray);
      return sha1(implode($signatureArray)) == $signature;
    }
#################zhubei for funtion "run()" #################
    protected function getRequest($param = FALSE) {   ###$param news'Contents
      if ($param === FALSE) {
        return $this->request;
      }
      $param = strtolower($param);
      if (isset($this->request[$param])) {
        return $this->request[$param];
      }
      return NULL;
    }
    protected function onSubscribe() {} #####protected  All_function
    protected function onUnsubscribe() {}
    protected function onText() {}  ####11111onText 
    protected function onUnknown() {}
    protected function responseText($content, $funcFlag = 0) { ###define 回复text yangshi!! 
      exit(new TextResponse($this->getRequest('fromusername'), $this->getRequest('tousername'), $content, $funcFlag));
    }
##################################define `run` 分析消息##################
    public function run() {
      switch ($this->getRequest('msgtype')) {  ###only one,it's product  or huanjin '$'
        case 'event':   ###
          switch ($this->getRequest('event')) {
            case 'subscribe':
              $this->onSubscribe();
              break;
            case 'unsubscribe':
              $this->onUnsubscribe();
              break;
          }
          break;
        case 'text':  #API/lib/weixin_authorize/api/custom.rb:9: # "msgtype":"text"
          $this->onText();  ####### run empty_funtion 'onText' !! 22222onText
          break;
        default:
          $this->onUnknown();  ###?? is have?
          break;
      }
    }
}

$ch = new Wechat();  ###Wechat Object( [request:Wechat:private] => Array ( [0] => ) )
print_r($ch);

?>
