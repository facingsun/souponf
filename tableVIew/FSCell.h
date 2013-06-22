//
//  FSCell.h
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EGOImageView;
@interface FSCell : UITableViewCell{
    UILabel *cellLabel;
    UITextView *textView;
    @private
    EGOImageView *imageView;
}

-(void)addCellHeadImageName:(NSString *)name CGRect:(CGRect)rect;
-(void)addTitleLabel:(NSString *)string CGRect:(CGRect)rect;
-(void)addTextViewText:(NSString *)string CGRect:(CGRect)rect;
@end
