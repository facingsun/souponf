//
// SPPullToRefresh.h
//
// Created by Sam Vermette on 23.04.12.
// Copyright (c) 2012 samvermette.com. All rights reserved.
//
// https://github.com/samvermette/SPPullToRefresh
//

#import <UIKit/UIKit.h>

enum {
    SPPullToRefreshStateHidden = 1,
	SPPullToRefreshStateVisible,
    SPPullToRefreshStateTriggered,
    SPPullToRefreshStateLoading
};

typedef NSUInteger SPPullToRefreshState;

@interface SPPullToRefresh : UIView

@property (nonatomic, strong) UIColor *arrowColor;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, readwrite) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) NSDate *lastUpdatedDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nonatomic, readonly) SPPullToRefreshState state;

- (void)triggerRefresh;
- (void)startAnimating;
- (void)stopAnimating;

@end


// extends UIScrollView

@interface UIScrollView (SPPullToRefresh)

- (void)addPullToRefreshWithActionHandler:(void (^)(void))actionHandler;
- (void)addInfiniteScrollingWithActionHandler:(void (^)(void))actionHandler;

@property (nonatomic, strong) SPPullToRefresh *pullToRefreshView;
@property (nonatomic, strong) SPPullToRefresh *infiniteScrollingView;

@property (nonatomic, assign) BOOL showsPullToRefresh;
@property (nonatomic, assign) BOOL showsInfiniteScrolling;

@end