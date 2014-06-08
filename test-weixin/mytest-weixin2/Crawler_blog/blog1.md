https://github.com/chanshunli/test-weixin
my.oschina.net/wchen/blog/151476
Rails4 已经移出了params可以解析xml的功能，拿rails4做微信API的童鞋们注意了
发表于10个月前(2013-08-09 06:48)   阅读（346） | 评论（3） 1人收藏此文章, 我要收藏
赞0
微信 Rails4 ROR4 微信API

拜读了用 Rails 搭建微信公众平台 API之后发现，params[:xml]这个办法在Rails 4里面已经被办掉了，于是就看了一下Rails 4的新特性发现XML Parameter parsing has been sent to a plugin.

于是就去找这个plugin了，在Github上，地址是https://github.com/rails/actionpack-xml_parser

而且人家也已经写了removed from core in Rails 4.0

但是发现star和fork还都是个位数字，估计用到这个功能的人应该是很少了，记得之前有句话说，2013年了，在也没有人拿xml当default api了，可是，为什么这个微信api还要post xml呢。。。。


