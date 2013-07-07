//
//  SPLoginViewController.h
//  SouPon
//
//  Created by Edward on 13-3-17.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPLoginViewController : UIViewController<UITextFieldDelegate,NSXMLParserDelegate>{
    NSMutableDictionary *d;
}
@property (retain, nonatomic) IBOutlet UIButton *toRe;
@property (retain, nonatomic) IBOutlet UIButton *backButton;
@property (retain, nonatomic) IBOutlet UIView *fView;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField;
@property (retain, nonatomic) IBOutlet UITextField *pawTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (retain, nonatomic) IBOutlet UIView *reView;
@property (retain, nonatomic) IBOutlet UIButton *registerButton;
@property (retain, nonatomic) IBOutlet UITextField *phoneTextField2;
@property (retain, nonatomic) IBOutlet UITextField *pawTextField2;
@property (retain, nonatomic) IBOutlet UITextField *checkpsdTextField;
- (IBAction)logiin:(id)sender;
- (IBAction)toR:(id)sender;

- (IBAction)regist:(id)sender;

- (IBAction)bttnCancel:(id)sender;
-(void)setAll:(NSData *)couponid;
@end
