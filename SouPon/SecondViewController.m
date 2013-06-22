//
//  SecondViewController.m
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "SecondViewController.h"
#import "FPPopoverController.h"
#import "FSTableViewController.h"

@interface SecondViewController (){
    FSTableViewController *hotController;
    FSTableViewController *groupController;
    FSTableViewController *brandController;
    FSTableViewController *arearController;
}
-(void)popover:(id)sender Table:(FSTableViewController *)controller;
-(void)clickRightButton:(id)sender;
-(void)hotListTable;
-(void)attentionToFav:(NSDictionary *)diction;
@end

@implementation SecondViewController
@synthesize allAreaButton;
@synthesize allBrandButton;
@synthesize allGroupButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"优惠搜索", @"优惠搜索");
        //self.tabBarItem.image = [UIImage imageNamed:@"second"];
        allCagListID=0;
        allBrandListID=0;
        districtListID=0;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    if (myFavID==YES) {
        myFavID=NO;
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath=[path objectAtIndex:0];
        NSString *plistPath=[filePath stringByAppendingPathComponent:@"attentionToFav.plist"];
        NSDictionary *dic=[[NSDictionary alloc]initWithContentsOfFile:plistPath];
        [self attentionToFav:dic];
        [dic release];
    }
    UIBarButtonItem *cityBarButton=[[UIBarButtonItem alloc]initWithTitle:@"搜索" style:UIBarButtonItemStyleBordered target:self action:@selector(clickRightButton:)];
    //NSLog(@"ssddd=%@",[cityBarButton description]);
    //NSLog(@"ssddd=%@",[self description]);
    [self.tabBarController.navigationItem setRightBarButtonItem:cityBarButton];
   // NSLog(@"ssddd=%@",[self.tabBarController.navigationItem.rightBarButtonItem description]);
     [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:0.9 green:0.1 blue:0.1 alpha:1.0]];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"优惠搜索"];
    
    [cityBarButton release];
    //NSLog(@"ssddd=%@",[self description]);
  
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self hotListTable];
    
}

-(void)viewDidUnload
{
    [allBrandButton release];
    [allGroupButton release];
    [allAreaButton release];
    [hotController release];
    [groupController release];
    [brandController release];
    [arearController release];
    [super release];
}

-(void)hotListTable{
    Citylist=6;
    if (!hotController) {
        hotController=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
        [hotController setCagID:0 BrandID:0 DistrictID:0];
        [hotController setController:self];
        //[hotController setAccessibilityFrame:CGRectMake(0, 28, self.view.frame.size.width, self.view.frame.size.height-27)];
        [hotController.view setFrame:CGRectMake(0, 28, self.view.frame.size.width, self.view.frame.size.height-27)];
        [self.view addSubview:hotController.view];
    }else{
        [hotController setCagID:allCagListID BrandID:allBrandListID DistrictID:districtListID];
        [hotController xmlParsexml];
        [hotController.tableView reloadData];       
    }

}

-(void)clickRightButton:(id)sender{
   // NSLog(@"click Second right tableBarButton");
   // NSLog(@"clickRightButton%d%d%d",allCagListID,allBrandListID,districtListID);
    [self hotListTable];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)popover:(id)sender Table:(FSTableViewController *)controller{
    
    FPPopoverController *popoverController=[[FPPopoverController alloc]initWithViewController:controller];
    popoverController.tint=FPPopoverDefaultTint;
    popoverController.arrowDirection=FPPopoverArrowDirectionAny;
    [popoverController presentPopoverFromView:sender];
    [popoverController release];
}

-(IBAction)clickGroupButton:(id)sender{
    //NSLog(@"clickGroupButton");//
    Citylist=1;
    if (!groupController) {
        groupController=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
        groupController.delegate=self;
    }
    else{
        
        [groupController xmlParsexml];
        [groupController.tableView reloadData];
    }
    [self popover:sender Table:groupController];
    
}

-(IBAction)clickBrandButton:(id)sender{
   // NSLog(@"clickBrandButton");
    Citylist=2;
    if (!brandController) {
        brandController=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
        brandController.delegate=self;
    }else{
        
        [brandController xmlParsexml];
        [brandController.tableView reloadData];
    }
    [self popover:sender Table:brandController];
}

-(IBAction)clickArearButton:(id)sender{
    //NSLog(@"clickArearButton");//
    Citylist=3;
    if (!arearController) {
        arearController=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
       arearController.delegate=self;
    }else{
        
        [arearController xmlParsexml];
        [arearController.tableView reloadData];
    }
    [self popover:sender Table:arearController];
    //[arearController release];
}

#pragma mark -PassString Delegate
-(void)selectbutton:(int)n ADDR:(NSString *)string ID:(NSInteger)selectId{
    
    if (n==1) {
        [self.allGroupButton setTitle:string forState:UIControlStateNormal];
        allCagListID=selectId;
        
    }
    else if(n==2){
        [self.allBrandButton setTitle:string forState:UIControlStateNormal];
        allBrandListID=selectId;
    }
    else if (n==3){
        [self.allAreaButton setTitle:string forState:UIControlStateNormal];
        districtListID=selectId;
        
        
    }
}

-(void)attentionToFav:(NSDictionary *)diction{
    NSDictionary *diction1=[[NSDictionary alloc]initWithDictionary:diction];
    //NSLog(@"attentionShop===%@ ",diction);
    [self.allGroupButton setTitle:[diction1 objectForKey:@"categorycaption"] forState:UIControlStateNormal];
    [self.allBrandButton setTitle:[diction1 objectForKey:@"brandcaption"] forState:UIControlStateNormal];
    [self.allAreaButton setTitle:[diction1 objectForKey:@"districtcaption"] forState:UIControlStateNormal];
    allCagListID=[[diction1 objectForKey:@"categoryid"] intValue];
    allBrandListID=[[diction1 objectForKey:@"brandid"] intValue];
    districtListID=[[diction1 objectForKey:@"districtid"] intValue];
//    NSLog(@"categorycaption%@",[diction1 objectForKey:@"categorycaption"]);
//    NSLog(@"brandcaption%@",[diction1 objectForKey:@"brandcaption"]);
//    NSLog(@"districtcaption%@",[diction1 objectForKey:@"districtcaption"]);
//    NSLog(@"categoryid=%d",[[diction1 objectForKey:@"categoryid"] intValue]);
//    NSLog(@"categoryid=%d",[[diction1 objectForKey:@"brandid"] intValue]);
//    NSLog(@"categoryid=%d",[[diction1 objectForKey:@"districtid"] intValue]);
    [self hotListTable];
    [diction1 release];
}
-(void)attentionShop:(NSDictionary *)diction{
    [self attentionToFav:diction];
}
/*
-(void)attentionShop:(NSDictionary *)diction{
   
    
    
     
     circumlist:{
     address = "\U5730\U5740\Uff1a\U5b81\U56fd\U5e02\U5c71\U95e8\U4e2d\U8def";
     brandcaption = "\U7f8e\U4f73\U6a71\U67dc";
     brandid = 14;
     caption = "\U7f8e\U4f73\U6a71\U67dc";
     categorycaption = "\U5bb6\U5c45\U5efa\U6750";
     categoryid = 7;
     description = "\U7535\U8bdd\Uff1a0563-4014189";
     distance = "661 \U5343\U7c73";
     districtcaption = "\U5b81\U56fd\U5e02";
     districtid = 16;
     icon = "130085794796875000807.jpg";
     id = 23;
     }
     
    
}*/
#pragma mark - PopoverController Delegate
-(void)presentedNewPopoverController:(FPPopoverController *)newPopoverController shouldDismissVisiblePopover:(FPPopoverController *)visiblePopoverController{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];
    
}
@end
