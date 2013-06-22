//
//  SPDetailViewController.m
//  SouPon
//
//  Created by Edward on 13-4-3.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "SPDetailViewController.h"
#import "SPStatic.h"
#import "EGOImageView.h"



@interface SPDetailViewController (){
    FSXml *detailXML;
    NSDictionary *dictionInfo;
    NSMutableArray *favorableList;
}
-(void)setTitle:(NSString *)title;
-(void)setContent:(NSString *)content;
-(void)setImage:(NSString *)iconName;
-(void)setDate:(NSString *)indate;
-(IBAction)clickButton:(id)sender;
-(void)setDiction:(NSDictionary *)diction tag:(int)i;
@end

@implementation SPDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        detailXML=[[FSXml alloc]init];
        detailXML.delegate=self;
        
    }
    return self;
}
-(void)viewDidUnload{
   
   [stroeButton release];
    [indateLabel release];
    [decLabel release];
    [infoIcon release];
    if (conTextView!=nil) {
        [conTextView release];
    }
     [dictionInfo release];
    if (detailXML!=nil) {
          [detailXML release];
    }
   [favorableList release];
    [super release];
    
}
-(void)dealloc{
    indateLabel=nil;
    stroeButton=nil;
    decLabel=nil;
    infoIcon=nil;
    conTextView=nil;
    
    [super dealloc];
}
-(void)viewDidDisappear:(BOOL)animated{
    fromTag=0;
    [stroeButton setEnabled:YES];

}
-(void)viewWillAppear:(BOOL)animated{
    if (decLabel==nil) {
        decLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.view.frame.size.height-20, 300, 20)];
        [decLabel setBackgroundColor:[UIColor clearColor]];
        [decLabel setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [decLabel setText:@"除特殊注明之外，本优惠券不能与其他优惠券同时使用"];
        [decLabel setTextColor:[UIColor redColor]];
        [self.view addSubview:decLabel];
        
    }
    
    if (stroeButton==nil) {
        stroeButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        stroeButton.backgroundColor=[UIColor clearColor];
        [stroeButton setFrame:CGRectMake(10, self.view.frame.size.height-61, 300, 40)];
        [stroeButton setBackgroundImage:[UIImage imageNamed:@"button_download_on.png"] forState:UIControlStateNormal];
        [stroeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [stroeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:stroeButton];   
    }
  if (fromTag==1) {
        
        [stroeButton setTitle:@"取消我的优惠券" forState:UIControlStateNormal];
    }
}

-(IBAction)clickButton:(id)sender{
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[path objectAtIndex:0];
    NSString *plistPath=[filePath stringByAppendingPathComponent:@"youhui.plist"];
    if ([stroeButton.titleLabel.text isEqualToString:@"收藏到我的优惠券"]) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]initWithDictionary:dictionInfo];
      //  NSLog(@"dictionInfo:%@",dictionInfo);
        [dic setValue:cellImage forKey:@"headImage"];
        [dic setValue:[NSString stringWithFormat:@"%d",cellTag] forKey:@"tag"];
       // NSLog(@"dic:%@",dic);
        // NSLog(@"favorableList write:%@",favorableList);
        [favorableList addObject:dic];
       // NSLog(@"favorableList write:%@",favorableList);
        [favorableList writeToFile:plistPath atomically:YES];
        [stroeButton setTitle:@"取消收藏" forState:UIControlStateNormal];
        [dic release];
        
    }
    else {
       // NSLog(@"celltag=%d",cellTag);
        for (unsigned int i=0;i<[favorableList count];i++) {
            NSDictionary *dic1=[NSDictionary dictionaryWithDictionary:[favorableList objectAtIndex:i]];
           // NSLog(@"celltag=%@",[dic1 objectForKey:@"tag"]);
            if ([[dic1 objectForKey:@"tag"]isEqual:[NSString stringWithFormat:@"%d",cellTag]]) {
                [favorableList removeObjectAtIndex:i];
                [favorableList writeToFile:plistPath atomically:YES];
                break;
            }
        }
        [stroeButton setTitle:@"收藏到我的优惠券" forState:UIControlStateNormal];
        if (fromTag==1) {
            [stroeButton setEnabled:NO];
        }
    }
  
}
-(void)setInfoId:(NSInteger)d imageName:(NSString *)i tag:(NSInteger)t{
    if (![detailXML initWithURL:[NSString stringWithFormat:@"%@%d",DETAILINFO,d] tag:0])
    {
        NSLog(@"error");
    }else{
        cellImage=[NSString stringWithString:i];
        cellTag=t;
    }
}
-(void)setinfoDiction:(NSDictionary *)diction infoId:(NSInteger)t{
    fromTag=1;
    cellTag=t;
    [self setDiction:diction tag:1];
}
-(void)setDate:(NSString *)indate{
    if (indateLabel==nil) {
         indateLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 338, 300, 15)];
    }
   
    [indateLabel setFont:[UIFont systemFontOfSize:12]];
    [indateLabel setBackgroundColor:[UIColor clearColor]];
    //[indateLabel setBackgroundColor:[UIColor colorWithRed:0.5 green:0.5  blue:0.5 alpha:1.0]];
    [indateLabel setText:[NSString stringWithFormat:@"有效日期:%@",indate]];
    [self.view addSubview:indateLabel];
   
}
-(void)setImage:(NSString *)iconName{
    detailImageView=[[EGOImageView alloc]initWithPlaceholderImage:[ UIImage imageNamed:@"detail_image_bg.gif"]];
    [detailImageView setFrame:CGRectMake(10, 175, 300, 160)];
    NSString *string=[NSString stringWithFormat:@"%@%@",GETIMAGE,iconName];
    string=[string stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];//需要转码，如果不转码有可能获取不到数据
    detailImageView.imageURL=[NSURL URLWithString:string];
    //NSLog(@"imagename:%@", string);
    [self.view addSubview:detailImageView];
    [detailImageView release];
}
-(void)setContent:(NSString *)content{
    if (conTextView==nil) {
        conTextView=[[UITextView alloc]initWithFrame:CGRectMake(10, 5, 300, 165)];
    }
    //[conTextView setBackgroundColor:[UIColor colorWithRed:0.49 green:0.49 blue:0.49 alpha:1.0]];
    [conTextView setBackgroundColor:[UIColor clearColor]];
    conTextView.editable=NO;
    [conTextView setFont:[UIFont systemFontOfSize:14]];
    [conTextView setText:content];
    [self.view addSubview:conTextView];
}
-(void)setTitle:(NSString *)title{
    UILabel *titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(-10, 0, 150, 44)];
    
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    int s=[title length];
    //NSLog(@"lenth=%d",s);
    if (s<10)
    {
        [titleLabel setFrame:CGRectMake(-10, 0, 150, 44)];
        [titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    else if(10<=s&&s<=25)
    {
        [titleLabel setFrame:CGRectMake(-10, 0, 180, 44)];
        [titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    else if(s>25)
    {
        [titleLabel setFrame:CGRectMake(-10, 0, 310, 44)];
        [titleLabel setFont:[UIFont systemFontOfSize:9]];
    }
    [titleLabel setText:title];
    self.navigationItem.titleView=titleLabel;   
    [titleLabel release];
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
-(void)setDiction:(NSDictionary *)diction tag:(int)i{

    dictionInfo=[[NSDictionary alloc]initWithDictionary:diction];
    [self setTitle:[dictionInfo objectForKey:@"caption"]];
    [self setContent:[dictionInfo objectForKey:@"content"]];
    [self setImage:[dictionInfo objectForKey:@"image"]];
    [self setDate:[dictionInfo objectForKey:@"indate"]];
    int n=1;
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[path objectAtIndex:0];
    NSString *plistPath=[filePath stringByAppendingPathComponent:@"youhui.plist"];
    if (favorableList==nil) {
         favorableList=[[NSMutableArray alloc]initWithCapacity:0];
    }
    if ([favorableList count]!=0) {
        [favorableList removeAllObjects];
    }
    NSArray *arr=[[NSArray alloc]initWithContentsOfFile:plistPath];
    //favorableList=[[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    [favorableList addObjectsFromArray:arr];
    [arr release];
//NSLog(@"favorableList:%@",[arr description]);
    //[favorableList addObjectsFromArray:arr];
    //NSLog(@"favorableList:%@",[favorableList description]);
    for (NSDictionary *dic1 in favorableList) {
        if ([[dic1 objectForKey:@"tag"]isEqual:[NSString stringWithFormat:@"%d",cellTag]]) {
            n=0;
            break;
        }
    }     
    if (n==0) {
        [stroeButton setTitle:@"取消我的优惠券" forState:UIControlStateNormal];
    }else if(n==1){
        [stroeButton setTitle:@"收藏到我的优惠券" forState:UIControlStateNormal];
    }
}
#pragma mark - XML Delegate

-(void)xmlParserFinished:(NSArray *)array tag:(int)tag{
    [self setDiction:[array objectAtIndex:0] tag:0];
    //NSLog(@"diction=%@",diction);
}

@end
