//
//  iOSimple+UIScrollView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIScrollView.h"

@implementation UIScrollView (iOSimple_UIScrollView)

UIView *_stickyView;
CGRect _stickyRect;

- (void)scrollToBottom {
    CGPoint bottomOffset = CGPointMake(0, self.contentSize.height - self.bounds.size.height);
    [self setContentOffset:bottomOffset animated:YES];
}

- (NSInteger)currentPage {
    CGFloat width = self.frame.size.width;
    NSInteger page = (self.contentOffset.x + (0.5f * width)) / width;
    return page;
}

- (void)setStickyHeader:(id)view {
    _stickyView     =   view;
    _stickyRect     =   CGRectMake(_stickyView.frame.origin.x, _stickyView.frame.origin.y, _stickyView.frame.size.width, _stickyView.frame.size.height);
    self.delegate   =   self;
}

#pragma mark    -   Delegate:

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!_stickyView) { return; }
    CGFloat y               =   -scrollView.contentOffset.y;
    if (y > 0) {
        _stickyView.frame   =   CGRectMake(0, scrollView.contentOffset.y, _stickyRect.size.width, _stickyRect.size.height+y);
        _stickyView.center  =   CGPointMake(self.center.x, _stickyView.center.y);
    }
}

- (void)addReloaderWithAction:(SEL)selector sender:(id)sender {
    
    NSPredicate *predicate  =   [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",[UIRefreshControl class]];
    NSArray *controls       =   [self.subviews filteredArrayUsingPredicate:predicate];
    
    if (controls.count != 0) { return; }
    
    UIRefreshControl *rc    =   [[UIRefreshControl alloc] init];
    [rc addTarget:sender action:selector forControlEvents:UIControlEventValueChanged];
    [self addSubview:rc];
    
}

- (void)action:(UIRefreshControl *)control {
    [control endRefreshing];
}

#pragma mark    -   Clear:

- (void)clearWithClass:(Class)class completion:(void (^)(void))completion {
    
    NSArray *subviews           =   self.subviews;
    
    if (class) {
        NSPredicate *predicate  =   [NSPredicate predicateWithFormat:@"self isKindOfClass: %@",class];
        subviews                =   [self.subviews filteredArrayUsingPredicate:predicate];
    }
    
    if (!subviews) { completion(); return; }
    if (subviews.count == 0) { completion(); return; }
    NSUInteger current      =   0;
    for (id obj in subviews) {
        current++;
        [UIView animateWithDuration:0.4 animations:^{
            [obj setAlpha:0];
        } completion:^(BOOL finished) {
            [obj removeFromSuperview];
            if (current == subviews.count) {
                completion();
            }
        }];
    }
}

- (void)clearWithClasses:(NSArray *)classes completion:(void (^)(void))completion {
    
    if (!classes) { completion(); return; }
    if (classes.count == 0) { completion(); return; }
    
    __block NSUInteger current  =   0;
    NSUInteger total            =   classes.count;
    
    for (Class className in classes) {
        [self clearWithClass:className completion:^{
            current++;
            if (current == total) {
                completion();
            }
        }];
    }
}

#pragma mark    -   Reset Content Size:

- (void)resetContentSize {
    [self setContentSize:CGSizeMake(0, 0)];
}

#pragma mark    -   Filtered Subviews:

- (NSArray *)filteredSubviewsWithClass:(Class)className {
    
    NSMutableArray *objects             =   [[NSMutableArray alloc] init];
    
    for (id obj in self.subviews) {
        if ([obj isKindOfClass:className]) {
            [objects addObject:obj];
        }
    }
    
    return objects;
    
}

@end

//
//
//

@implementation EasyScroller : UIScrollView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.alreadySetup) {
        [self setupScroller];
        self.alreadySetup = YES;
    }
}

- (void)setupScroller {
    if (self.widthEnabled && self.heightEnabled) {
        self.contentSize    =   CGSizeMake(self.contentWidth, self.contentHeight);
        return;
    }
    if (self.widthEnabled) {
        self.contentSize    =   CGSizeMake(self.contentWidth, self.contentSize.height);
        return;
    }
    if (self.heightEnabled) {
        self.contentSize    =   CGSizeMake(self.contentSize.width, self.contentHeight);
        return;
    }
}

@end
