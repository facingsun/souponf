//
//  SPUIViewPassStringDelegate.h
//  Soupon
//
//  Created by Edward on 13-3-13.
//
//

#import <Foundation/Foundation.h>

@protocol SPUIViewPassStringDelegate <NSObject>
@optional -(void)passString:(NSString *)string;
@optional -(void)citySelect:(NSInteger)cityID;
@optional -(void)selectbutton:(int)n ID:(NSInteger)selectId;
@optional -(void)selectbutton:(int)n ADDR:(NSString *)string ID:(NSInteger)selectId;
@optional -(void)attentionShop:(NSDictionary *)diction;
@end
