//
//  iOSimple+UIScrollView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIScrollView (iOSimple_UIScrollView) <UIScrollViewDelegate>

- (void)scrollToBottom;
- (NSInteger)currentPage;
- (void)setStickyHeader:(id)view;
- (void)addReloaderWithAction:(SEL)selector sender:(id)sender;

@end

//
//
//

@interface EasyScroller : UIScrollView

@property (nonatomic, assign) BOOL alreadySetup;
@property (nonatomic, assign) IBInspectable BOOL widthEnabled;
@property (nonatomic, assign) IBInspectable CGFloat contentWidth;
@property (nonatomic, assign) IBInspectable BOOL heightEnabled;
@property (nonatomic, assign) IBInspectable CGFloat contentHeight;

@end
