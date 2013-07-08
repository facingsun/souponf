//
//  FourViewController.m
//  SouPon
//
//  Created by Edward on 13-2-26.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FourViewController.h"
#import "HelporAboutViewController.h"
#import "SPLoginViewController.h"
#import "SPStatic.h"
#import "SPMyFavViewController.h"
#import "FSTableViewController.h"

@interface FourViewController (){
    HelporAboutViewController *aboutViewController;
    HelporAboutViewController *helpViewController;
    HelporAboutViewController *myViewController;
    SPMyFavViewController *favViewController;
    SPMyFavViewController *attViewController;
    
}

@end

@implementation FourViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"我的优惠", @"我的优惠");
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
        myFavID=NO;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setRightBarButtonItem:nil];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"我的优惠"];
    if (myFavID==YES) {
        self.tabBarController.selectedIndex=1;
    }
   
}

-(void)viewDidUnload{
    [attViewController reloadInputViews];
    [favViewController release];
    if (aboutViewController) {
           [aboutViewController release];
    }
    if (helpViewController) {
        [helpViewController release];
    }
    [tempDic release];
    [super release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)myCouPonClick:(id)sender{
    Citylist=7;
    UIViewController *viewCon = [[UIViewController alloc]init];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
        
        SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
        [self presentModalViewController:loginCon animated:YES];
        [viewCon release];
        return;
    }
    if (favViewController ==  nil) {
        favViewController= [[SPMyFavViewController alloc]init];
    }
    [self.tabBarController.navigationItem setTitle:@"返回"];
    
    [self.navigationController pushViewController:favViewController animated:YES];
    [viewCon release];
    return;  
}
-(IBAction)myNodeClick:(id)sender{
    Citylist=8;
    UIViewController *viewCon = [[UIViewController alloc]init];
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
        SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
        [self presentModalViewController:loginCon animated:YES];
        [viewCon release];
        return;
    }
    [self.tabBarController.navigationItem setTitle:@"返回"];
    if (attViewController ==  nil) {
        attViewController= [[SPMyFavViewController alloc]init];
                
    }
    [self.tabBarController.navigationItem setTitle:@"返回"];
    [self.navigationController pushViewController:attViewController animated:YES];
     [viewCon release];
    return;
    
}

-(IBAction)guessClick:(id)sender{
    UIViewController *viewCon = [[UIViewController alloc]init];
     NSLog(@"guessClick");
    if (![[NSUserDefaults standardUserDefaults]objectForKey:@"phone"]) {
        SPLoginViewController *loginCon = [[[SPLoginViewController alloc]init]autorelease];
        [self presentModalViewController:loginCon animated:YES];
        [viewCon release];
        return;
    }
    
    [self.navigationController setNavigationBarHidden:NO];
    NSString *phone = [[NSUserDefaults standardUserDefaults]objectForKey:@"phone"];
    NSURLRequest *request =[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:GUESS,phone]]];
    [self.tabBarController.navigationItem setTitle:@"返回"];
    
    UIWebView *webView = [[UIWebView alloc]init];
    [webView loadRequest:request];
    [viewCon setView:webView];
    [webView release];
    [self.navigationController pushViewController:viewCon animated:YES];
	[viewCon release];

}

-(IBAction)helpClick:(id)sender{
     NSLog(@"helpClick");
    if (!helpViewController) {
        helpViewController=[[HelporAboutViewController alloc]initWithCag:1];
    }
    if (helpViewController) {
        [self.navigationController pushViewController:helpViewController animated:YES];
    }
    
}

-(IBAction)aboutClick:(id)sender{
     NSLog(@"aboutClick");
    if (!aboutViewController) {
        aboutViewController=[[HelporAboutViewController alloc]initWithCag:0];
    }
    if (aboutViewController) {
        [self.navigationController pushViewController:aboutViewController animated:YES];
    }   
}
- (void)dealloc {
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
@end
