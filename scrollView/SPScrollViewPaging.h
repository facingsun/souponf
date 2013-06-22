//
//  SPScrollViewPaging.h
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPScrollViewPaging : UIScrollView <UIScrollViewDelegate> {
    BOOL pageControlBeingUsed;
    NSArray *_pages;
    UIPageControl *pageControl;
    int iNumber;
}

@property (nonatomic) int currentPage;
@property (nonatomic) BOOL hasPageControl;
@property (nonatomic, strong) UIColor *pageControlCurrentPageColor;
@property (nonatomic, strong) UIColor *pageControlOtherPagesColor;
- (void)addPages:(NSArray *)pages;

@end
