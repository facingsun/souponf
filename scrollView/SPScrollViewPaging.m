//
//  SPScrollViewPaging.m
//  ScrollViewPaging
//
//  Created by Andrea Lufino on 15/02/13.
//  Copyright (c) 2013 Andrea Lufino. All rights reserved.
//

#import "SPScrollViewPaging.h"

@implementation SPScrollViewPaging
@synthesize currentPage;/////////////
@synthesize hasPageControl=_hasPageControl;////////////
@synthesize pageControlCurrentPageColor=_pageControlCurrentPageColor;
@synthesize pageControlOtherPagesColor=_pageControlOtherPagesColor;

const int kDotWidth = 7;

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //setting the 'must have' properties
        [self setBackgroundColor:[UIColor clearColor]];
        self.pagingEnabled = YES;//设置是否按页显示
        iNumber=0;
        //self.showsHorizontSPScrollIndicator=NO;
        self.showsHorizontalScrollIndicator=NO;//设置是否显示滑动条
        self.delegate = self;
        //pageControlBeingUsed = NO;
        //self.bounces = NO;//设置是否有滑动过再返回的动画在起始页和最后一页
        pageControl = [[UIPageControl alloc] init];//初始化UIpageControl
        pageControl.backgroundColor=[UIColor clearColor];
    }
    return self;
}
/*
- (id)initWithFrame:(CGRect)frame andPages:(NSArray *)pages
{
    self = [super initWithFrame:frame];
    if (self) {
        //add pages to scrollview
        [self addPages:pages];
    }
    return self;
}
*/
#pragma mark - Setter

//setter for hasPageControl property
//if is YES, we can create the page control and place it under the scrollview
- (void)setHasPageControl:(BOOL)hasPageControl
{
    _hasPageControl = hasPageControl;
    if (hasPageControl) {
        [pageControl setNumberOfPages:[_pages count]];//设置pagecontrol的索引点的个数
        [pageControl setCurrentPage:0];//设置初始第几个索引被锁定
        int pWidth =kDotWidth * [_pages count];//设置pageControl的宽度
        int pageControlX = self.frame.size.width  - (pWidth )-30;//设置pagecontrol其实位置的x坐标  
        int pageControlY = self.frame.origin.y + self.frame.size.height-10;
        [pageControl setFrame:CGRectMake(pageControlX, pageControlY,pWidth,0)];
        //setFrame设置pageControl的大小，并且其中的点是居中显示的
        [pageControl addTarget:self action:@selector(changePage:) forControlEvents:UIControlEventValueChanged];
   
            [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollViewDidScroll) userInfo:nil repeats:YES];//定时器，实现每隔2秒跳转一个页面
        //[pageControl setPageIndicatorTintColor:[UIColor yellowColor]];//这两个方法ios6以下不支持
        [[self superview] addSubview:pageControl];
    }
    else
    {
        for (UIPageControl *pControl in [[self superview] subviews])
        {
            if ([pControl isEqual:pageControl])
            {
                [pageControl removeFromSuperview];
            }
        }
    }

}

//set the color of the current page dot
- (void)setPageControlCurrentPageColor:(UIColor *)pageControlCurrentPageColor {
    _pageControlCurrentPageColor = pageControlCurrentPageColor;
   // pageControl.currentPageIndicatorTintColor = pageControlCurrentPageColor;
}

//set the color of the others pages indicators
- (void)setPageControlOtherPagesColor:(UIColor *)pageControlOtherPagesColor {
    _pageControlOtherPagesColor = pageControlOtherPagesColor;
    //pageControl.pageIndicatorTintColor = pageControlOtherPagesColor;
}

#pragma mark - Add pages

//add pages to the scrollview
- (void)addPages:(NSArray *)pages {
    _pages = [pages retain];
    int numberOfPages = [pages count];
    for (int i = 0; i < [pages count]; i++) {
        CGRect frame;
        frame.origin.x = self.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.frame.size;
        UIView *view = [pages objectAtIndex:i];
        [view setFrame:frame];
        [self addSubview:view];
    }
    self.contentSize = CGSizeMake(self.frame.size.width * numberOfPages, self.frame.size.height);
}

#pragma mark - Change page through page control

//method for paging
- (void)changePage:(id)sender {
    //update the scroll view to the appropriate page
	CGRect frame;
	frame.origin.x = self.frame.size.width * self.currentPage;
   // NSLog(@"change=%f",frame.origin.x);
	frame.origin.y = 0;
	frame.size = self.frame.size;
	[self scrollRectToVisible:frame animated:YES];
	pageControlBeingUsed = YES;
}

#pragma mark - ScrollView delegate

//methods for paging
- (void)scrollViewDidScroll
{
    //switch the page when more than 50% of the previous/next page is visible	
    pageControl.currentPage = iNumber;//设置pagecontrol的索引，且第几个点锁定
    [self setContentOffset:CGPointMake(self.frame.size.width*iNumber ,0) animated:YES];
    iNumber++;
    if (iNumber==[_pages count]) {
        iNumber=0;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed = NO;
    //NSLog(@"Dragging");
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed =NO;
   // NSLog(@"Deceleratings");
}


-(void)dealloc{
    
    [_pages release];
    [pageControl release];
    [_pageControlCurrentPageColor release];
    [_pageControlOtherPagesColor release];
    [super dealloc];
}

@end
