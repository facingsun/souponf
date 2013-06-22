
#ifndef SPSTATIC_H
#define SPSTATIC_H


//hotlist id="",caption="",description="",icon="",popularity=
#define HOTLIST @"http://www.sltouch.com/soupon/mobile/hotlist.aspx?city=1&begin=0&max=10"
#define CITYHOTLIST @"http://www.sltouch.com/soupon/mobile/hotlist.aspx?city="
#define CITYHOTLISTAMOUNT @"&begin=0&max="
//城市列表返回值id="",caption=""
#define CITYLIST @"http://www.sltouch.com/soupon/mobile/citylist.aspx"
//加载图片格式为后边直接加图片名字
#define GETIMAGE @"http://www.sltouch.com/soupon/mobile/upload/"
//获取广告图片名字
#define ADS @"http://www.sltouch.com/soupon/mobile/adbanner.aspx"
//后去热门优惠图片名字
#define ADS @"http://www.sltouch.com/soupon/mobile/adbanner.aspx"
//优惠搜索
//#define CIRCUMSELECT @"http://www.sltouch.com/soupon/mobile/couponlist.aspx?category=%d&brand=%d&district=%d&begin=0&max=10"//(原型)
#define FAVORABLESELECT @"http://www.sltouch.com/soupon/mobile/couponlist.aspx?"
#define CATEGORYURLID @"category="
#define BRANDURLID @"&brand="
#define DISTRICT @"&district="
#define FAVORABLEAMOUNT @"&begin=0&max="

//周边搜索
#define CIRCLESELECT @"http://www.sltouch.com/soupon/mobile/nearby.aspx?x=%@&y=%@&begin=0&max=10"
#define CIRCLEX @"http://www.sltouch.com/soupon/mobile/nearby.aspx?x="
#define CIRCLEY @"&y="
#define CIRCLEAMOUNT @"&begin=0&max="

//店铺优惠详细信息，后边跟店铺ID
#define DETAILINFO @"http://www.sltouch.com/soupon/mobile/detail.aspx?couponid="

#define MATCHLIST @"http://www.sltouch.com/soupon/mobile/match.aspx?object=" 

#define GROUPLIST  @"category"  //分类
#define BRANDLIST @"brand"    //品牌
#define AREALIST @"district"  //商圈

//注册
#define CHECKUSER @"http://www.sltouch.com/soupon/mobile/register.aspx?action=%@&phone=%@&password=%@&email="
//猜猜活动
#define GUESS @"http://www.sltouch.com/soupon/mobile/guess.aspx?phone=%@"

int Citylist;//所有的辨别url的id
int CityID;//点击城市按钮，里边城市的按钮
BOOL myFavID;//在跳转的时候辨别我的关注

#endif
 