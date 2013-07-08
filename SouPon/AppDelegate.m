//
//  AppDelegate.m
//  SouPon
//
//  Created by Edward on 13-2-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "AppDelegate.h"

#import "FirstViewController.h"

#import "SecondViewController.h"

#import "ThirdViewController.h"

#import "FourViewController.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_tabBarController release];
    [_navigationControl release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2,*viewController3,*viewController4;
    //创建tableBar选项
    //if ([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPhone) {
        viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil] autorelease];
        viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil] autorelease];
        viewController3 = [[[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil] autorelease];
        viewController4 = [[[FourViewController alloc] initWithNibName:@"FourViewController" bundle:nil] autorelease];
   // } else {
     //   viewController1 = [[[FirstViewController alloc] initWithNibName:@"FirstViewController_iPad" bundle:nil] autorelease];
      //  viewController2 = [[[SecondViewController alloc] initWithNibName:@"SecondViewController_iPad" bundle:nil] autorelease];
//}
    //创建一个tablebar实例
    self.tabBarController = [[[UITabBarController alloc] init] autorelease];
    //创建一个navigationControl实例,并将tableBar添加到其中，将navigation作为tableBar导航（这里导航的是tableBar不是tableBar总的选项所以所有选项在navigation中属于同一级别，即所有选项用的是同一个导航条，所以在设置不同页面不同导航条标题时，导航条的几个按钮和标题都要重新设置，没有的可以设置为空，否者如果该选项view 的某个属性不需要设置，而其他的选项view设置了，这里又没有重置，则在该选项view中将显示其他view的设置在该属性上）
    [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1.0]];
    NSArray *array=[[NSArray alloc]initWithObjects:@"soupon",@"search",@"around",@"my", nil];
    for (int i=0; i<[array count]; i++) {
        UIImageView  *imageview=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",[array objectAtIndex:i]]]];
        [imageview setFrame:CGRectMake(i*80+24, 4, 32, 32)];
        [self.tabBarController.tabBar insertSubview:imageview atIndex:1];
         [imageview release];
    }
    [array release];
    self.navigationControl=[[[UINavigationController alloc]initWithRootViewController:self.tabBarController]autorelease];
    [self.navigationControl.navigationBar setTintColor:[UIColor colorWithRed:0.9 green:0.2 blue:0.2 alpha:1.0]];
    
    //[UIColor colorWithRed:0.9 green:0.3 blue:0.3 alpha:1.0]
    //将实例选项添加到tablebar的实例中
    self.tabBarController.viewControllers = @[viewController1, viewController2,viewController3,viewController4];
    //将导航控制器添加到root控制器中作为第一个页面
    self.window.rootViewController = self.navigationControl;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
