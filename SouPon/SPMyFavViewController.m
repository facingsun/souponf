//
//  SPMyFavViewController.m
//  SouPon
//
//  Created by Edward on 13-6-18.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "SPMyFavViewController.h"
#import "FSTableViewController.h"
#import "SPStatic.h"


@interface SPMyFavViewController (){
    FSTableViewController *tableViewController;
}

@end

@implementation SPMyFavViewController
//@synthesize tableViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewDidUnload{
    
    [tableViewController release];
    [super viewDidUnload];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    //Citylist=7;
    if (Citylist==7) {
        self.navigationItem.title=@"我的优惠";
    }else{
        self.navigationItem.title=@"我的关注";
    }
    
    if (!tableViewController) {
    
       tableViewController=[[FSTableViewController alloc]initWithStyle:UITableViewScrollPositionNone];
        [tableViewController.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height )];
        [tableViewController setController:self];
        [self.view addSubview:tableViewController.view];
    }else{
        [tableViewController xmlParsexml];
    }
    //[tableViewController release];
//[tableViewController.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
