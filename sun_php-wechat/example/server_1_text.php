<?php  ###from HTML to Model : Controller   ###duo'page dong_hua : yi_zhen=500page
  require('../src/Wechat.php');
  class MyWechat extends Wechat {
    protected function onSubscribe() { ########
      $this->responseText('欢迎关注');
    }
    protected function onUnsubscribe() {
    }
    protected function onText() {  ######## Cover empty_funtion onText!! 33333onText
      $this->responseText('收到了文字消息：' . $this->getRequest('content')); ###use responseText & getRequest('content')++>get_All_Contonts
    }
  }
  $wechat = new MyWechat('weixin', TRUE);
  $wechat->run();  ###Call run()
?>
