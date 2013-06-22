//
//  FSCell.m
//  TableViewDemo
//
//  Created by Edward on 13-3-29.
//  Copyright (c) 2013年 Edward. All rights reserved.
//

#import "FSCell.h"
#import "SPStatic.h"
#import "EGOImageView.h"
#import "QuartzCore/QuartZCore.h"

@implementation FSCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
    }
    return self;
}

-(void)addCellHeadImageName:(NSString *)name CGRect:(CGRect)rect
{
    if (!imageView) {
        imageView=[[EGOImageView alloc]init];
        
    }
    [imageView setImage:[UIImage imageNamed:@"Default@2x.png"]];
    imageView.frame=rect;
    [self addSubview:imageView];
    imageView.imageURL=[NSURL URLWithString:name];
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    if(!newSuperview){
        [imageView cancelImageLoad];
    }
}

-(void)addTitleLabel:(NSString *)string CGRect:(CGRect)rect
{
    if (!cellLabel) {
        cellLabel=[[UILabel alloc]init];
    }
    int s=[string length];
    if (s<10)
    {
        [cellLabel setFont:[UIFont systemFontOfSize:18]];
        
    }
    else if(12<=s&&s<22)
    {
        [cellLabel setFont:[UIFont systemFontOfSize:14]];
    }
    else if(s>=22&&s<40)
    {
        [cellLabel setFont:[UIFont systemFontOfSize:9]];
    }
    else if(s>=40)
    {
        [cellLabel setFont:[UIFont systemFontOfSize:6]];
    }
    [cellLabel setFrame:rect];
    [cellLabel setText:string];
    [self.contentView addSubview:cellLabel];
}

-(void)addTextViewText:(NSString *)string CGRect:(CGRect)rect
{
    if (!textView) {
        textView=[[UITextView alloc]init];
        [textView setEditable:NO];
        [textView setUserInteractionEnabled:NO];
        
    }
    int s=[string length];
    if (s<20)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 150, 44)];
        [textView setFont:[UIFont systemFontOfSize:14]];
        
    }
    else if(20<=s&&s<40)
    {
        //[titleLabel setFrame:CGRectMake(-10, 0, 180, 44)];
        [textView setFont:[UIFont systemFontOfSize:11]];
    }
    else if(s>40)
    {
        // [titleLabel setFrame:CGRectMake(-10, 0, 310, 44)];
        [textView setFont:[UIFont systemFontOfSize:8]];
    }
    [textView setFrame:rect];
     //textView.text=string;
    [textView setText:string];
    [self.contentView addSubview:textView];
}


-(void)dealloc{
    [textView release];
    [cellLabel release];
    [imageView release];
    imageView=nil;
    textView=nil;
    cellLabel=nil;
    [super dealloc];
}
@end
