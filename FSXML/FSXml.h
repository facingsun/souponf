//
//  FSXml.h
//  XmlText
//
//  Created by Edward on 13-3-26.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol xmlDelegate //<NSObject>

@optional -(void)xmlParserFinished:(NSArray *)array tag:(int)tag;

@end

@interface FSXml : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *XMLArray;//此数组用以指向传入的array数组，array数组通过该数组获取数据。
    NSURLConnection *connection1;
    NSMutableData *xmlData;
    id<xmlDelegate> *delegate;
    int _tag;
}
@property(nonatomic,assign)id<xmlDelegate>delegate;

-(BOOL)initWithURL:(NSString *)str XmlDataToArray:(NSMutableArray *)array;
-(BOOL)initWithURL:(NSString *)str tag:(int)tag;

@end
