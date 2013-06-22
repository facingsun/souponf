//
//  FirstViewController.m
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FirstViewController.h"
#import "FPPopoverController.h"
#import "SPScrollViewPaging.h"
#import "FSTableViewController.h"

#import "EGOImageView.h"



@interface FirstViewController (){
    FSTableViewController *tableViewController;
    UIBarButtonItem *cityBarButton;
    NSDictionary *firstCityDic;
    UIView *buttonView;
    FSTableViewController *cityController;
    FSXml *cityXML;
    FSXml *adXML;
    
}
-(void)clickLeftButton:(id)sender;
-(void)hotListTable;
-(void)adScrollView:(NSArray *)adInfoArray;
@end

@implementation FirstViewController
//初始化nib的时候加载
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        myFavID=NO;
        self.title = NSLocalizedString(@"环旗优惠", @"环旗优惠");//
        //self.tabBarItem.image = [UIImage imageNamed:@"first"];
       
        //NSLog(@"asddasd:%@",[self.navigationController.viewControllers description]);
        cityXML=[[FSXml alloc]init];
        //NSMutableArray *infoTableArray=[NSMutableArray arrayWithCapacity:0];
        if (![cityXML initWithURL:CITYLIST tag:0])
        {
            NSLog(@"error");
        }
        cityXML.delegate=self;
        cityBarButton=[[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(clickLeftButton:)];//实例化一个BarButtonitem并设置标题为"城“市，按钮触发事件为clickLeftButton:(id)sender
        adXML=[[FSXml alloc]init];
        if (![adXML initWithURL:[NSString stringWithFormat:@"%@",ADS] tag:1])
        {
            NSLog(@"error");
            [adXML release];
        }
        adXML.delegate=self;
    }
  
    
    return self;
}


-(void)viewDidUnload{
    [tableViewController release];
    [cityBarButton release];
    [firstCityDic release];
    [ADArray release];
    [cityXML release];
    [buttonView release];
    [adXML release];
    [cityController release];
    [super release];
}

//当view即将显示的时候加载
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.navigationItem setLeftBarButtonItem:cityBarButton];//将上边button添加为导航条的做按钮
    [self.tabBarController.navigationItem.leftBarButtonItem setTintColor:[UIColor colorWithRed:0.9 green:0.3 blue:0.3 alpha:1.0]];
    [self.tabBarController.navigationItem  setRightBarButtonItem:nil];//右侧button设置为nil
    [self.tabBarController.navigationItem setTitle:@"环旗优惠"];//设置标题
    
    
    
    
    //[self.tabBarController.navigationControll]
}

-(void)adScrollView:(NSArray *)adInfoArray
{
    
    //NSMutableArray *adInfoArray=[NSMutableArray arrayWithCapacity:0];
  
    if(ADArray!=nil)
    {
        [ADArray release];
    }
    ADArray=[[NSArray alloc]initWithArray:adInfoArray];
    //[xmlParse release];
    SPScrollViewPaging *scrollView=[[SPScrollViewPaging alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
    NSMutableArray *views=[[NSMutableArray alloc]init];
    for (int i=0; i<[ADArray count]; i++)
    {
        NSDictionary *adDiction=[ADArray objectAtIndex:i];
        NSString *adUrl=[NSString stringWithFormat:@"%@%@",GETIMAGE,[adDiction objectForKey:@"poster"]];
        adUrl=[adUrl stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];//需要转码，如果不转码有可能获取不到数据
        adImageView=[[EGOImageView alloc]initWithPlaceholderImage:[ UIImage imageNamed:@"Default@2x.png"]];
        [views addObject:adImageView];
        adImageView.imageURL=[NSURL URLWithString:adUrl];
        [adImageView release];
    }
    
    [scrollView addPages:views];
    [self.view addSubview:scrollView];
    [scrollView setHasPageControl:YES];
    [ADArray release];
    [views release];
    [scrollView release];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //[self adScrollView];

    
}

//hot tableview
-(void)hotListTable
{
    Citylist=4;
    //FSTableViewController *tableViewController=[[FSTableViewController alloc]initWithStyle:UITableViewScrollPositionNone];
    if (!tableViewController) {
        tableViewController=[[FSTableViewController alloc]initWithStyle:UITableViewScrollPositionNone];
        [tableViewController.view setFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height-150 )];
        [tableViewController setController:self];
        [self.view addSubview:tableViewController.view];
    }else{
        [tableViewController xmlParsexml];
        //[tableViewController.tableView reloadData];
    }
    
   // [tableViewController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//city list button
-(void)clickLeftButton:(id)sender
{
  //  NSLog(@"firstView cityClickLeftButton");/////////////////////////////////
    Citylist=0;
    if (!buttonView) {
         buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 55) ];
    }
    if (!cityController) {
        cityController=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
    }
    FPPopoverController *popoverController=[[FPPopoverController alloc]initWithViewController:cityController];
    cityController.delegate=self;
    popoverController.tint=FPPopoverDefaultTint;
    popoverController.arrowDirection=FPPopoverArrowDirectionAny;
    [popoverController presentPopoverFromView:buttonView];
    [popoverController release];
 
}


#pragma mark -PassString Delegate
-(void)passString:(NSString *)string
{
    cityBarButton.title=string;
}

-(void)citySelect:(NSInteger)cityID{
    
   // NSLog(@"sdfsdfdsfs");
    CityID=cityID;
    [self hotListTable];
}
-(void)selectbutton:(int)n ADDR:(NSString *)string ID:(NSInteger)selectId{
    
    if (n==0) {
        cityBarButton.title=string;
        CityID=selectId;
        [self hotListTable];
    }
}
#pragma mark - PopoverController Delegate
-(void)presentedNewPopoverController:(FPPopoverController *)newPopoverController shouldDismissVisiblePopover:(FPPopoverController *)visiblePopoverController{
    [visiblePopoverController dismissPopoverAnimated:YES];
    [visiblePopoverController autorelease];    
}


#pragma mark - XML Delegate

-(void)xmlParserFinished:(NSArray *)array tag:(int)tag{
    if (tag==0) {
        firstCityDic=[[NSDictionary alloc]initWithDictionary:[array objectAtIndex:0]];
        NSString *str=[firstCityDic objectForKey:@"id"];
        CityID=[str integerValue];
        NSString *firstCity=[[NSString stringWithFormat:@"%@",[firstCityDic objectForKey:@"caption"]] copy];
        if ([firstCity length]==0) {
           //实例化一个BarButtonitem并设置标题为"城“市，按钮触发事件为clickLeftButton:(id)sender
            [cityBarButton setTitle:@""];
        }else{
            //实例化一个BarButtonitem并设置标题为"城“市，按钮触发事件为clickLeftButton:(id)sender
            [cityBarButton setTitle:firstCity];
        }
        [firstCity release];
        [self hotListTable];

    }else if(tag==1){
        [self adScrollView:array];
    }

}

@end
