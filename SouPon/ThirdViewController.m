//
//  ThirdViewController.m
//  SouPon
//
//  Created by Edward on 13-3-21.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "ThirdViewController.h"
#import "FSTableViewController.h"

@interface ThirdViewController (){
    FSTableViewController *controller;
}
-(void)clickUpdateBarButton:(id)Sender;
-(void)hotListTable;
@end

@implementation ThirdViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"周边优惠", @"周边优惠");
            //self.tabBarItem.image = [UIImage imageNamed:@"first"];
        // lon=112.549279;
        // lat=32.968966;
        lon=121.519279;
        lat=31.968966;;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    UIBarButtonItem *cityBarButton=[[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleBordered target:self action:@selector(clickUpdateBarButton:)];
    [self.tabBarController.navigationItem setRightBarButtonItem:cityBarButton];
     [self.tabBarController.navigationItem.rightBarButtonItem setTintColor:[UIColor colorWithRed:0.9 green:0.3 blue:0.3 alpha:1.0]];
    [self.tabBarController.navigationItem  setLeftBarButtonItem:nil];
    [self.tabBarController.navigationItem setTitle:@"周边优惠"];
    [cityBarButton release];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    
}
-(void)viewDidUnload{
    [controller release];
    [super release];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    locationManager=[[CLLocationManager alloc]init];
    [locationManager setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    [locationManager startUpdatingLocation];
   [self hotListTable];
}

-(void)hotListTable
{
    Citylist=5;
    //FSTableViewController *controller=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
    if (!controller) {
        controller=[[FSTableViewController alloc]initWithStyle:UITableViewStylePlain];
        [controller.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        [controller setController:self];
        [self.view addSubview:controller.view];

    }else{
      [controller setCircleLongitude:lon latitude:lat];
        [controller xmlParsexml];
        [controller.tableView reloadData];
    }

     //   [controller release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

-(void)clickUpdateBarButton:(id)Sender{
    //NSLog(@"click Third update Button");
    [locationManager startUpdatingLocation];
   // [self hotListTable];
}


#pragma LOCATION
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    //NSLog(@"经度=%f,纬度=%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude);
    lon=newLocation.coordinate.longitude;
    lat=newLocation.coordinate.latitude;
    //[mapLabel setText:[NSString stringWithFormat:@"经度=%f,纬度=%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude]];
    [self hotListTable];
    [locationManager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Could not find location:%@",error);
}
@end
