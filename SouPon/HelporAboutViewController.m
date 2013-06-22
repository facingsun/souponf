//
//  HelporAboutViewController.m
//  SouPon
//
//  Created by Edward on 13-4-23.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "HelporAboutViewController.h"
#import "SPScrollViewPaging.h"

@interface HelporAboutViewController (){
    UIImageView *aboutImageView;
    NSMutableArray *views;
    SPScrollViewPaging *helpScroll;
}

-(void)displayAboutImage;
-(void)displayHelpImage;

@end

@implementation HelporAboutViewController
-(id)initWithCag:(int)c{
    if (!self) {
         self=[super init];
    }
    if (self) {
        cag=c;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     views=[[NSMutableArray alloc]init];
    for (int i=1; i<=4; i++)
    {
        UIImageView *adImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"help_%d.png",i]]];
        [views addObject:adImageView];
        [adImageView release];
    }
    if (cag==0) {
        [self displayAboutImage];
    }
    else if(cag==1){
        [self displayHelpImage];
    }
}

-(void)displayHelpImage{
    if (!helpScroll) {
         helpScroll=[[SPScrollViewPaging alloc]initWithFrame:self.view.frame];
    }
    [helpScroll addPages:views];
    [self.view addSubview:helpScroll];
    [helpScroll setHasPageControl:NO];
    
}
-(void)displayAboutImage{
    if (!aboutImageView) {
        aboutImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
        //self.delegate=aboutImageView;
    }
    [aboutImageView setImage:[UIImage imageNamed:@"aboutus_bg.png"]];
    [self.view addSubview:aboutImageView];
}
-(void)viewDidUnload{
    if (aboutImageView) {
        [aboutImageView release];
    }
    if (views) {
        [views release];
    }
    if (helpScroll) {
        [helpScroll release];
    }
    [super release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
