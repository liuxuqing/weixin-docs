<?php
$xmlstring = <<<XML
<xml>
<ToUserName>GuangZhou</ToUserName>
<FromUserName>ShunliChan</FromUserName>
<CreateTime>Now</CreateTime>
<MsgType>MsgType</MsgType>
<Content>I Love you</Content>
<FuncFlag>0000</FuncFlag>
</xml>
XML;

$xml = simplexml_load_string($xmlstring);

var_dump($xml);
?>
