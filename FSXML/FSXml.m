//
//  FSXml.m
//  XmlText
//
//  Created by Edward on 13-3-26.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FSXml.h"

@implementation FSXml
@synthesize delegate=_delegate;
-(id)init{
    self=[super init];
    return self;
}

-(BOOL)initWithURL:(NSString *)string XmlDataToArray:(NSMutableArray *)array{
    NSURL *url=[NSURL URLWithString:string];//将连接转化为url对象
    NSError *error=nil;
    XMLArray=array;
    NSString *str=[[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];//将url对象给string对象，并转码
    if (error)
    {
        NSLog(@"%@",error);
        [str release];
        return NO;
    }
    NSXMLParser *parser=[[[NSXMLParser alloc]initWithData:[str dataUsingEncoding:NSUTF8StringEncoding]]autorelease];//初始化Parser解析对象
    [parser setDelegate:self];//设置委托获取数据
    [parser parse];
    [str release];
    return YES;
}


-(void)fetchEntries{
    xmlData=[[NSMutableData alloc]init];
    //NSURLConnection
}
-(BOOL)initWithURL:(NSString *)string tag:(int)tag{
    xmlData=[[NSMutableData alloc]init];///////
    _tag=tag;
    NSURL *url=[NSURL URLWithString:string];//将连接转化为url对象
    // NSLog(@"%@",url);
    NSURLRequest *req=[NSURLRequest requestWithURL:url];
    connection1=[[NSURLConnection alloc]initWithRequest:req delegate:self startImmediately:YES];
    XMLArray=[[NSMutableArray alloc]init];
    return YES;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [xmlData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSXMLParser *parser=[[NSXMLParser alloc]initWithData:xmlData];
    //NSLog(@"sdfsdfsdfsd");
    [parser setDelegate:self];
    //NSLog(@"sdfsdfsdfsd");
    [parser parse];
    xmlData=nil;
    connection1=nil;
    [_delegate xmlParserFinished:XMLArray tag:_tag];
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    connection1=nil;
    xmlData=nil;
    NSString *errorString=[NSString stringWithFormat:@"Fetch failed:%@",[error localizedDescription]];
    UIAlertView *av=[[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
    [av release];
    
}


#pragma mark NSXMLParser Deledate Methods
//解析核心部分，该方法每一组数据调用一次。
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //这里attributeDict参数存储由解析后的数据，本例中连接可用该参数， 第一个和第二个参数用法待定？？？
    //if ([attributeDict objectForKey:@"id"]) {//判断改组获取的数据是否为空 为空则不执行下边内容
    if ([attributeDict count]>0) {
        //NSDictionary *diction=[[NSDictionary alloc]initWithDictionary:attributeDict];//将attributeDict中的内容给diction，通过这样以防出了该方法数据丢失
        [XMLArray addObject:attributeDict];//将字典对象加入数组中        
        //[diction release];//释放对象
        //不用上边申请的字典对象也可以。
       // NSLog(@"xml=%@",attributeDict);
    }
    
    
}
-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
}

-(void)dealloc{
    [super dealloc];
  
}

-(void)delete:(id)sender{
    
    [super dealloc];
    [xmlData release];
    [connection1 release];
    [XMLArray release];
}

@end
