//
//  FSTableViewController.h
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPStatic.h"
#import "SPUIViewPassStringDelegate.h"
#import "FSXml.h"

enum SPUrlTag{
    CityList=0,     //城市
    allCagList=1,   //全部分类
    allBrandList=2, //全部品牌
    districtList=3, // 全部商圈
    hotList=4,      //热门列表
    circumlist=5,    //周边优惠
    selectList=6,    //优惠搜索
    myfavorable=7,   //我的优惠券
    attention=8     //关注店铺
    
};

@class SPDetailViewController;

@interface FSTableViewController : UITableViewController<UIAlertViewDelegate,xmlDelegate>
{
    NSInteger allCagListID;//选中全部分类ID
    NSInteger allBrandListID;//选中品牌ID
    NSInteger districtListID;//选中商圈ID
    enum SPUrlTag eUrlTag;
    int selectRow;
    double lon;
    double lat;
    NSMutableArray *attentionShopaArray;
    NSObject<SPUIViewPassStringDelegate> *delegate;
    NSMutableArray *_array;//存储解析的数据
    UIViewController *detailcontroller;//获取父视图控制器
    SPDetailViewController *detailViewController;//详细信息视图控制器
    BOOL attentionShopIS;
}

@property(retain,nonatomic)NSObject<SPUIViewPassStringDelegate> *delegate;

-(void)setCircleLongitude:(double)longitude latitude:(double)latitude;
-(void)setCagID:(NSInteger)cageID BrandID:(NSInteger)brandID DistrictID:(NSInteger)districtID;//设置要解析数据的id地址
-(void)setController:(UIViewController *)controller;//设置父视图控制器对象
-(void)xmlParsexml;//选择xml解析连接函数

@end
