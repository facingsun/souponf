//
//  FirstViewController.h
//  SouPon
//
//  Created by Edward on 13-2-26.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"
#import "SPUIViewPassStringDelegate.h"
#import "FSXml.h"

@class EGOImageView;

@interface FirstViewController : UIViewController<FPPopoverControllerDelegate,SPUIViewPassStringDelegate,xmlDelegate>
{
    NSArray *ADArray;
    EGOImageView *adImageView;

}
-(void)clickLeftButton:(id)sender;
@end
