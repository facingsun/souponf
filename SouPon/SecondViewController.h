//
//  SecondViewController.h
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "SPUIViewPassStringDelegate.h"

@interface SecondViewController : UIViewController<FPPopoverControllerDelegate,SPUIViewPassStringDelegate>{
    NSInteger allCagListID;
    NSInteger allBrandListID;
    NSInteger districtListID;
}
@property(nonatomic,retain)IBOutlet UIButton *allGroupButton;//全部分类
@property(nonatomic,retain)IBOutlet UIButton *allBrandButton;//品牌
@property(nonatomic,retain)IBOutlet UIButton *allAreaButton;//商圈

-(IBAction)clickGroupButton:(id)sender;
-(IBAction)clickBrandButton:(id)sender;
-(IBAction)clickArearButton:(id)sender;

@end
