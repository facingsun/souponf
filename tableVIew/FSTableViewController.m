//
//  FSTableViewController.m
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FSTableViewController.h"
#import "FSCell.h"
#import "SPPullToRefresh.h"

#import "SPDetailViewController.h"
#import "SecondViewController.h"

@interface FSTableViewController (){
    NSDictionary *attentionShopDiction;
    //UIAlertView *alerDialog;
    FSXml *xmlParse;
    int loadNum;
}
-(void)attentionOrGotoShop:(NSString *)string shopid:(NSInteger)i;
@end

@implementation FSTableViewController
@synthesize delegate;

-(void)viewDidUnload{
    if (_array!=nil) {
        [_array release];
    }
    [detailViewController release];
    //[alerDialog release];
    [xmlParse release];
    [attentionShopaArray release];
    [super release];
}

-(void)xmlParsexml{
    if (eUrlTag!=myfavorable&&eUrlTag!=attention) {
        xmlParse=[[FSXml alloc]init];
        xmlParse.delegate=self;
        //NSMutableArray *infoTableArray=[NSMutableArray arrayWithCapacity:0];
        if(eUrlTag==CityList)
        {
            if (![xmlParse initWithURL:CITYLIST tag:CityList])
            {
                NSLog(@"error");
            }
            
        }
        else if(eUrlTag==allCagList)
        {
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%@",MATCHLIST,GROUPLIST] tag:allCagList])
            {
                NSLog(@"error");
            }
        }
        else if(eUrlTag==allBrandList)
        {
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%@",MATCHLIST,BRANDLIST] tag:allBrandList])
            {
                NSLog(@"error");
            }
        }
        else if(eUrlTag==districtList)
        {
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%@",MATCHLIST,AREALIST] tag:districtList])
            {
                NSLog(@"error");
            }
        }
        else if(eUrlTag==hotList)
        {
            
            /*if (![xmlParse initWithURL:HOTLIST XmlDataToArray:infoTableArray])
            {
                NSLog(@"error");
            }*/
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%d%@%d",CITYHOTLIST,CityID,CITYHOTLISTAMOUNT,loadNum] tag:hotList])
            {
                NSLog(@"error");
            }

        }
        else if(eUrlTag==circumlist)
        {
            
            /*if (![xmlParse initWithURL:HOTLIST XmlDataToArray:infoTableArray])
             {
                 NSLog(@"error");
             }*/
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%f%@%f%@%d",CIRCLEX,lon,CIRCLEY,lat,CIRCLEAMOUNT,loadNum] tag:circumlist])
            {
                NSLog(@"error");
            }
           // NSDictionary *diction=[[NSDictionary alloc]initWithDictionary:[infoTableArray objectAtIndex:0]];
           // NSString *string1=[NSString stringWithFormat:@"%@",diction];
           // string1=[string1 stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFAbsoluteTimeIntervalSince1970)];//需要转码，如果不转码有可能获取不到数据
           // string1=[string1 stringByReplacingPercentEscapesUsingEncoding:CFStringConvertEncodingToWindowsCodepage(kCFAbsoluteTimeIntervalSince1970)];
            
           // NSLog(@"circumlist:%@",string1);
            
        }
        else if(eUrlTag==selectList)
        {
        
            if (![xmlParse initWithURL:[NSString stringWithFormat:@"%@%@%d%@%d%@%d%@%d",FAVORABLESELECT,CATEGORYURLID,allCagListID,BRANDURLID,allBrandListID,DISTRICT,districtListID,FAVORABLEAMOUNT,loadNum] tag:selectList])
            {
                NSLog(@"error");
            }
        }
    }else if(eUrlTag==myfavorable||eUrlTag==attention){
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath=[path objectAtIndex:0];
        NSString *plistPath;
        if (eUrlTag==myfavorable) {
            plistPath=[filePath stringByAppendingPathComponent:@"youhui.plist"];
        }else {
            plistPath=[filePath stringByAppendingPathComponent:@"attentionShop.plist"];
        }
        
        if(_array!=nil)
            [_array release];
        _array=[[NSMutableArray alloc]initWithArray:[NSMutableArray arrayWithContentsOfFile:plistPath]];
        [self.tableView reloadData];
    }
   // NSLog(@"count=%d",[array count]);
    //[xmlParse release];
    
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if(Citylist>=0)
            eUrlTag=Citylist;
        //NSLog(@"eurlTad=%d",eUrlTag);
       // lon=112.549279;
       // lat=32.968966;
        lon=121.519279;
        lat=31.968966;
        loadNum=10;
    }
    return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    
    //if (eUrlTag==myfavorable) {
       // [self xmlParsexml];
       // [self.tableView reloadData];
   // }
    [self xmlParsexml];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self xmlParsexml];
    //NSLog(@"asdfas=%d",[array count]);
    if (eUrlTag!=myfavorable&&eUrlTag!=attention) {
        [self.tableView addPullToRefreshWithActionHandler:^{
            NSLog(@"refresh dataSource");
            if (self.tableView.pullToRefreshView.state == SPPullToRefreshStateLoading)
                NSLog(@"Pull to refresh is loading");
            
            [self.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
            [self xmlParsexml];
            
        }];
        if (self.tableView.pullToRefreshView.state == SPPullToRefreshStateHidden)
            NSLog(@"Pull to refresh is hidden");
        [self.tableView addInfiniteScrollingWithActionHandler:^{
            NSLog(@"load more data");
            loadNum+=10;
            [self xmlParsexml];
            [self.tableView.pullToRefreshView performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
            if (self.tableView.pullToRefreshView.state == SPPullToRefreshStateHidden)
                NSLog(@"Pull to refresh is hidden");
        }];
    }
        
    selectRow=0;
    
    
    //trigger the refresh manually at the end of viewDidLoad
    //[self.tableView.pullToRefreshView triggerRefresh];//在这里执行会在打开页面时进行刷新
}


-(void)setCircleLongitude:(double)longitude latitude:(double)latitude{
    
    lon=longitude;
    lat=latitude;
    
}

-(void)setController:(UIViewController *)controller{
    
    detailcontroller=controller;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setCagID:(NSInteger)cageID BrandID:(NSInteger)brandID DistrictID:(NSInteger)districtID{
    allCagListID=cageID;
    allBrandListID=brandID;
    districtListID=districtID;
}
#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    //NSLog(@"sdfsdfsdf");
    //NSLog(@"count:%d",[_array count]);
    if(_array!=nil){
       // NSLog(@"count:%d",[_array count]);
        return [_array count];
    }
   else return 0;
    //return [array count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (Citylist==0||Citylist==1||Citylist==2||Citylist==3) {
        return 40;
    }else
        return 60;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    FSCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[[FSCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
   for (UIView *view in  cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    NSDictionary *dictionary=[_array objectAtIndex:indexPath.row];
    if (indexPath.row>=0&& (eUrlTag==0||eUrlTag==1||eUrlTag==2||eUrlTag==3)) {
        
        if(dictionary!=nil){
            cell.textLabel.text = [NSString stringWithFormat:@"%@",[dictionary objectForKey:@"caption"]];
            [cell setTag:[[dictionary objectForKey:@"id"] intValue]];
            if (indexPath.row==0) {
                
            }
            //[dictionary release];//这里不可以释放，因为dictionary只是获取了指向数组中某个元素地址的指针，没有retain；
            dictionary=nil;
        }else{
            cell.textLabel.text = [NSString stringWithFormat:@""];
        }
    }
    else  if(eUrlTag==hotList||eUrlTag==circumlist||eUrlTag==selectList||eUrlTag==attention){
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        NSString *string=[NSString stringWithFormat:@"%@%@",GETIMAGE,[dictionary objectForKey:@"icon"]];
        string=[string stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];//需要转码，如果不转码有可能获取不到数据
        [cell addCellHeadImageName:string CGRect:CGRectMake(4, 4, 65, 52)];
        [cell addTitleLabel:[dictionary objectForKey:@"caption"] CGRect:CGRectMake(80, 4, cell.frame.size.width-75, 20)];
        [cell addTextViewText:[dictionary objectForKey:@"description"] CGRect:CGRectMake(75, 25, cell.frame.size.width-75, 35)];
        [cell setTag:[[dictionary objectForKey:@"id"] intValue]];
        dictionary=nil;
    }else if(eUrlTag==myfavorable)
    {
       // NSLog(@"myfavorable");
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        NSString *string=[NSString stringWithFormat:@"%@%@",GETIMAGE,[dictionary objectForKey:@"headImage"]];
        string=[string stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];//需要转码，如果不转码有可能获取不到数据
        [cell addCellHeadImageName:string CGRect:CGRectMake(4, 4, 65, 52)];
        
        [cell addTitleLabel:[dictionary objectForKey:@"caption"] CGRect:CGRectMake(80, 4, cell.frame.size.width-75, 20)];
        
        [cell addTextViewText:[dictionary objectForKey:@"content"] CGRect:CGRectMake(75, 25, cell.frame.size.width-75, 35)];
        
        [cell setTag:[[dictionary objectForKey:@"tag"] intValue]];
        //NSLog(@"dic=%@",dictionary);
        dictionary=nil;
    }
        
    if (indexPath.row==0&&(eUrlTag==0||eUrlTag==1||eUrlTag==2||eUrlTag==3)&&selectRow==0) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [delegate selectbutton:eUrlTag ADDR:cell.textLabel.text ID:cell.tag];
    }
    else if((indexPath.row==selectRow&&selectRow!=0)||(selectRow>=15&&indexPath.row==0))
    {//这个else是防止选中的选项在下拉被覆盖后变为未选中状态
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [CellIdentifier release];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

-(void)attentionOrGotoShop:(NSString *)string shopid:(NSInteger)i{
    //NSLog(@"attentionOrGotoShop");
    attentionShopIS=NO;
    NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath=[path objectAtIndex:0];
    NSString *plistPath=[filePath stringByAppendingPathComponent:@"attentionShop.plist"];
    if (attentionShopaArray==nil) {
        attentionShopaArray=[[NSMutableArray alloc]initWithCapacity:0];
    }
    if ([attentionShopaArray count]!=0) {
        [attentionShopaArray removeAllObjects];
    }
    NSArray *arr=[[NSArray alloc]initWithContentsOfFile:plistPath];
    [attentionShopaArray addObjectsFromArray:arr];
    [arr release];
    for (NSDictionary *dic1 in attentionShopaArray) {
        if ([[dic1 objectForKey:@"id"]isEqual:[attentionShopDiction objectForKey:@"id"]]) {
            attentionShopIS=YES;
            ///NSLog(@"attentionShopArray");
            break;
        }
    }
    if (attentionShopIS) {
       UIAlertView *alerDialog=[[[UIAlertView alloc]initWithTitle:@"欢迎光临" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"店内优惠",@"取消关注", @"取消",nil]autorelease];
        [alerDialog setMessage:string];
        [alerDialog show];
    }else
    {
      UIAlertView *alerDialog=[[[UIAlertView alloc]initWithTitle:@"欢迎光临" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"店内优惠",@"关注本店", @"取消",nil]autorelease];
        [alerDialog setMessage:string];
        [alerDialog show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        if (eUrlTag!=attention) {
                    detailcontroller.tabBarController.selectedIndex=1;//实现跳转到指定的在tableBar中的view
             UIViewController *viewController1=[detailcontroller.tabBarController.viewControllers objectAtIndex:1];
             self.delegate=viewController1;
            [delegate attentionShop:attentionShopDiction];
            //NSLog(@"sdfsdwew:%@",[viewController1 description]);
        }else{
            myFavID=YES;
            NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *filePath=[path objectAtIndex:0];
            NSString *plistPath=[filePath stringByAppendingPathComponent:@"attentionToFav.plist"];
            [attentionShopDiction writeToFile:plistPath atomically:YES];
            [detailcontroller.navigationController popViewControllerAnimated:NO];
            //NSLog(@"sdds:%@",[viewcontrooler3 description]);
          
        }      
        //NSLog(@"attentionShopDiction====%@",attentionShopDiction);
    }
    else if(buttonIndex==1){
        //NSLog(@"keep a watchful eye on the shop");
        NSArray *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *filePath=[path objectAtIndex:0];
        NSString *plistPath=[filePath stringByAppendingPathComponent:@"attentionShop.plist"];
        if (attentionShopIS) {
            [attentionShopaArray removeObject:attentionShopDiction];   
        }else{
            [attentionShopaArray addObject:attentionShopDiction];
        } 
        //NSLog(@"array=%@",[attentionShopaArray description]);
        [attentionShopaArray writeToFile:plistPath atomically:YES];
        if (eUrlTag==attention) {
            [self xmlParsexml];
            [self.tableView reloadData];
        }
    }
    else{
        NSLog(@"cancel");
    }
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    FSCell *cell=(FSCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if((eUrlTag==0||eUrlTag==1||eUrlTag==2||eUrlTag==3))
    {
        
        //NSLog(@"cell.textLabel.text=%@",cell.textLabel.text);
        if (eUrlTag==0) {
            [delegate selectbutton:0 ADDR:cell.textLabel.text ID:cell.tag];
        }
        else if(eUrlTag==1)
        {
            [delegate selectbutton:1 ADDR:cell.textLabel.text ID:cell.tag];
        }
        else if(eUrlTag==2)
        {
            [delegate selectbutton:2 ADDR:cell.textLabel.text ID:cell.tag];
        }
        else if(eUrlTag==3)
        {
            [delegate selectbutton:3 ADDR:cell.textLabel.text ID:cell.tag];
        }
        
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    // if (selectRow<15) {//小于tableView的行数
        if (selectRow!=indexPath.row ) {
            NSIndexPath *selectPath=[NSIndexPath indexPathForRow:selectRow inSection:0];
            cell=(FSCell *)[self.tableView cellForRowAtIndexPath:selectPath];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        selectRow=indexPath.row;
    }
    NSDictionary *diction=[_array objectAtIndex:indexPath.row];
    if (eUrlTag==hotList||eUrlTag==selectList||eUrlTag==myfavorable)
    {
        if (detailViewController==nil)
        {
           detailViewController=[[SPDetailViewController alloc]init ];         
        }
        //NSLog(@"cell.tag=%d",cell.tag);
        if(eUrlTag!=myfavorable){
            [detailViewController setInfoId:cell.tag imageName:[diction objectForKey:@"icon"] tag:cell.tag];
        }else{
            [detailViewController setinfoDiction:diction infoId:cell.tag];
            //NSLog(@"tag=%d",cell.tag);
        }
        [detailcontroller.navigationController pushViewController:detailViewController animated:YES];
    }
    
    if (eUrlTag==circumlist||eUrlTag==attention) {
        attentionShopDiction=[_array objectAtIndex:indexPath.row];
        [self attentionOrGotoShop:[diction objectForKey:@"caption"] shopid:cell.tag];
        //NSLog(@"shopName=%@",[diction objectForKey:@"caption"]);
    }
}

#pragma mark - XML Delegate
-(void)xmlParserFinished:(NSArray *)array tag:(int)tag{
    if(_array!=nil)
        [_array release];
    _array=[[NSMutableArray alloc]initWithCapacity:0];
    if (eUrlTag==allCagList) {
        NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"全部分类" ,@"caption",@"0",@"id",@"0",@"keyWord", nil];
        [_array addObject:dictionary];
        [dictionary release];
        
    }else if(eUrlTag==allBrandList){
        NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"全部品牌" ,@"caption",@"0",@"id",@"0",@"keyWord", nil];
        [_array addObject:dictionary];
        [dictionary release];  
    }
    else if(eUrlTag==districtList){
        NSDictionary *dictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"全部商圈" ,@"caption",@"0",@"id",@"0",@"keyWord", nil];
        [_array addObject:dictionary];
        [dictionary release];
    }
    [_array addObjectsFromArray:array];
    //_array=[[NSMutableArray alloc]initWithArray:array];
    [self.tableView reloadData];
}

@end
