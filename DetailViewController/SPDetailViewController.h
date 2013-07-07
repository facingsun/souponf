//
//  SPDetailViewController.h
//  SouPon
//
//  Created by Edward on 13-3-3.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSXml.h"

@class EGOImageView;

@interface SPDetailViewController : UIViewController<xmlDelegate>
{
    UIButton *stroeButton;
    UILabel *decLabel;
    UILabel *indateLabel;
    UIImageView *infoIcon;
    UITextView *conTextView;
    NSString *cellImage;
    NSInteger cellTag;
     EGOImageView *detailImageView;
    int fromTag;
}
-(void)setInfoId:(NSInteger)d imageName:(NSString *)i tag:(NSInteger)t;
-(void)setinfoDiction:(NSDictionary *)diction infoId:(NSInteger)t;


@end
