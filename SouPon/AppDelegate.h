//
//  AppDelegate.h
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationControl;

@property (strong, nonatomic) UITabBarController *tabBarController;

@end
