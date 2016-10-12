//
//  ViewController.m
//  HSActionSheet
//
//  Created by 海尔智能-李松 on 16/3/16.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//
// standard colors

//- (void)setTitleTextColor:(UIColor *)color;
//- (void)setButtonTextColor:(UIColor *)color;
//- (void)setTitleBackgroundColor:(UIColor *)color;
//- (void)setButtonBackgroundColor:(UIColor *)color;
//- (UIColor *)buttonTextColorAtIndex:(NSInteger)index;
//- (UIColor *)buttonBackgroundColorAtIndex:(NSInteger)index;
//- (void)setButtonTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//- (void)setButtonBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//
//
//// highlight colors
//- (void)setButtonHighlightBackgroundColor:(UIColor *)color;
//- (void)setButtonHighlightTextColor:(UIColor *)color;
//- (void)setButtonHighlightTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;
//- (void)setButtonHighlightBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index;

#import "XCActionSheet.h"

#define TestRedColor  [UIColor colorWithRed:1.000 green:0.229 blue:0.000 alpha:1.000]
#define TestBlueColor  [UIColor colorWithRed:0.000 green:0.500 blue:1.000 alpha:1.000]

/*************************************************    HSActionSheet   ************************************************************/
#pragma mark - HSActionSheet

@implementation XCActionSheet

#pragma mark HSActionSheet Set up methods

- (id)init {
    
    self = [self initWithFrame:CGRectMake(0, 0, 0, 0)];
    self.buttonResponse = XCActionSheetButtonResponseFadesOnPress;
    self.backgroundColor = [UIColor clearColor];
    self.buttons = [[NSMutableArray alloc] init];
    self.shouldCancelOnTouch = YES;
    
    self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetHeight([UIScreen mainScreen].bounds))];
    self.transparentView.backgroundColor = [UIColor blackColor];
    self.transparentView.alpha = 0.0f;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeFromView)];
    tap.numberOfTapsRequired = 1;
    [self.transparentView addGestureRecognizer:tap];
    
    return self;
}


- (id)initWithTitle:(NSString *)title
    buttonResponseType:(XCActionSheetButtonResponse)buttonResponseType
              delegate:(id<XCActionSheetDelegate>)delegate
     cancelButtonTitle:(NSString *)cancelTitle
destructiveButtonTitle:(NSString *)destructiveTitle
     otherButtonTitles:(NSString *)otherTitles, ...{
    
    self = [self init];
    self.delegate = delegate;
    self.backgroundColor = [UIColor clearColor];
    self.buttonResponse = XCActionSheetButtonResponseShrinksOnPress;
    
    NSMutableArray *titles = [[NSMutableArray alloc] init];
    
    if (otherTitles) {
        va_list args;
        va_start(args, otherTitles);
        for (NSString *arg = otherTitles; arg != nil; arg = va_arg(args, NSString* ))
        {
            [titles addObject:arg];
        }
        va_end(args);
    }
    
    if (destructiveTitle) {
        [titles insertObject:destructiveTitle atIndex:0];
        self.hasDestructiveButton = YES;
    } else {
        self.hasDestructiveButton = NO;
    }
    
    /*设置取消按钮*/
    if (cancelTitle) {
        XCActionSheetButton *cancelButton = [[XCActionSheetButton alloc] initWithAllCornersRounded];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:21];
        [cancelButton setTitle:cancelTitle forState:UIControlStateAll];
        [self.buttons addObject:cancelButton];
        self.hasCancelButton = YES;
    } else {
        self.shouldCancelOnTouch = NO;
        self.hasCancelButton = NO;
    }
    
    switch (titles.count) {
            
        case 0: {
            break;
        }
            
        case 1: {
            
            XCActionSheetButton *otherButton;
            
            if (title) {
                otherButton = [[XCActionSheetButton alloc] initWithBottomCornersRounded];
            } else {
                otherButton = [[XCActionSheetButton alloc] initWithAllCornersRounded];
            }
            
            [otherButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:otherButton atIndex:0];
            
            break;
            
        } case 2: {
            
            XCActionSheetButton *otherButton = [[XCActionSheetButton alloc] initWithBottomCornersRounded];
            [otherButton setTitle:[titles objectAtIndex:1] forState:UIControlStateAll];
            
            XCActionSheetButton *secondButton;
            
            if (title) {
                secondButton = [[XCActionSheetButton alloc] init];
            } else {
                secondButton = [[XCActionSheetButton alloc] initWithTopCornersRounded];
            }
            
            [secondButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:secondButton atIndex:0];
            [self.buttons insertObject:otherButton atIndex:1];
            
            break;
            
        } default: {
            
            XCActionSheetButton *bottomButton = [[XCActionSheetButton alloc] initWithBottomCornersRounded];
            [bottomButton setTitle:[titles lastObject] forState:UIControlStateAll];
            
            XCActionSheetButton *topButton;
            
            if (title) {
                topButton = [[XCActionSheetButton alloc] init];
            } else {
                topButton = [[XCActionSheetButton alloc] initWithTopCornersRounded];
            }
            
            [topButton setTitle:[titles objectAtIndex:0] forState:UIControlStateAll];
            [self.buttons insertObject:topButton atIndex:0];
            
            NSInteger whereToStop = titles.count - 1;
            for (int i = 1; i < whereToStop; ++i) {
                XCActionSheetButton *middleButton = [[XCActionSheetButton alloc] init];
                [middleButton setTitle:[titles objectAtIndex:i] forState:UIControlStateAll];
                [self.buttons insertObject:middleButton atIndex:i];
            }
            
            [self.buttons insertObject:bottomButton atIndex:(titles.count - 1)];
            
            break;
        }
    }
    
    [self setUpTheActions];
    
    if (destructiveTitle) {
        [[self.buttons objectAtIndex:0] setTextColor:TestRedColor];
        [[self.buttons objectAtIndex:0] setOriginalTextColor:TestRedColor];
    }
    
    for (int i = 0; i < self.buttons.count; ++i) {
        [[self.buttons objectAtIndex:i] setIndex:i];
    }
    
    if (title) {
        self.title = title;
    } else {
        [self setUpTheActionSheet];
    }
    
    return self;
}

- (void)setUpTheActionSheet {
    
    float height;
    float width;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    
    
//    // 轻微的调整，考虑到非视网膜设备
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]
//        && [[UIScreen mainScreen] scale] == 2.0) {
    
        // 视网膜屏幕设置
        if (self.hasCancelButton) {
            height = 59.5;
        } else {
            height = 104.0;
        }
        
        if (self.buttons.count) {
            height += (self.buttons.count * 44.5);
        }
        if (self.titleView) {
            height += CGRectGetHeight(self.titleView.frame) - 44;
        }
        
        self.frame = CGRectMake(0, 0, width, height);
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        CGPoint pointOfReference = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) - 30);
        
        NSInteger whereToStop;
        if (self.hasCancelButton) {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            [[self.buttons objectAtIndex:0] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - 52)];
            pointOfReference = CGPointMake(pointOfReference.x, pointOfReference.y - 52);
            whereToStop = self.buttons.count - 2;
        } else {
            [self addSubview:[self.buttons lastObject]];
            [[self.buttons lastObject] setCenter:pointOfReference];
            whereToStop = self.buttons.count - 1;
        }
        
        for (int i = 0, j = (int)whereToStop; i <= whereToStop; ++i, --j) {
            [self addSubview:[self.buttons objectAtIndex:i]];
            [[self.buttons objectAtIndex:i] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - (44.5 * j))];
        }
        
        if (self.titleView) {
            [self addSubview:self.titleView];
            self.titleView.center = CGPointMake(self.center.x, CGRectGetHeight(self.titleView.frame) / 2.0);
        }
        
//    } else {
//        
//        // setup spacing for non-retina devices
//        
//        if (self.hasCancelButton) {
//            height = 60.0;
//        } else {
//            height = 104.0;
//        }
//        
//        if (self.buttons.count) {
//            height += (self.buttons.count * 45);
//        }
//        if (self.titleView) {
//            height += CGRectGetHeight(self.titleView.frame) - 45;
//        }
//        
//        self.frame = CGRectMake(0, 0, width, height);
//        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//        
//        CGPoint pointOfReference = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight(self.frame) - 30);
//        
//        NSInteger whereToStop;
//        if (self.hasCancelButton) {
//            [self addSubview:[self.buttons lastObject]];
//            [[self.buttons lastObject] setCenter:pointOfReference];
//            [[self.buttons objectAtIndex:0] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - 52)];
//            pointOfReference = CGPointMake(pointOfReference.x, pointOfReference.y - 52);
//            whereToStop = self.buttons.count - 2;
//        } else {
//            [self addSubview:[self.buttons lastObject]];
//            [[self.buttons lastObject] setCenter:pointOfReference];
//            whereToStop = self.buttons.count - 1;
//        }
//        
//        for (int i = 0, j = whereToStop; i <= whereToStop; ++i, --j) {
//            [self addSubview:[self.buttons objectAtIndex:i]];
//            [[self.buttons objectAtIndex:i] setCenter:CGPointMake(pointOfReference.x, pointOfReference.y - (45 * j))];
//        }
//        
//        if (self.titleView) {
//            [self addSubview:self.titleView];
//            self.titleView.center = CGPointMake(self.center.x, CGRectGetHeight(self.titleView.frame) / 2.0);
//        }
//    }
    
}
/**
 *  创建ActionSheet各按钮视图
 */
- (void)setUpTheActions {
    
    for (XCActionSheetButton *button in self.buttons) {
        if ([button isKindOfClass:[XCActionSheetButton class]]) {
             /*点击抬起的action*/
            [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
            /*按下按钮时的action*/
            [button addTarget:self action:@selector(highlightPressedButton:) forControlEvents:UIControlEventTouchDown];
            
            [button addTarget:self
                       action:@selector(unhighlightPressedButton:)
             forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchCancel | UIControlEventTouchDragExit];
        }
    }
}

/**
 *  选中按钮按下时的执行效果
 *
 *  @param button 所点击的效果
 */
- (void)highlightPressedButton:(XCActionSheetButton *)button {
    
    [UIView animateWithDuration:0.15f
                     animations:^() {
                         
                         if (self.buttonResponse == XCActionSheetButtonResponseFadesOnPress) {
                             /*设置透明*/
                             button.alpha = .80f;
                         } else if (self.buttonResponse == XCActionSheetButtonResponseShrinksOnPress) {
                              /*设置放缩*/
                             button.transform = CGAffineTransformMakeScale(.98, .95);
                         } else if (self.buttonResponse == XCActionSheetButtonResponseHighlightsOnPress) {
                              /*设置高亮*/
                             button.backgroundColor = button.highlightBackgroundColor;
                             [button setTitleColor:button.highlightTextColor forState:UIControlStateAll];
                         } else {
                              /*设置反色*/
                             UIColor *tempColor = button.titleLabel.textColor;
                             [button setTitleColor:button.backgroundColor forState:UIControlStateAll];
                             button.backgroundColor = tempColor;
                         }
                     }];
}

/**
 *  点击结束时的动画执行效果
 *
 *  @param button 所点击的按钮
 */
- (void)unhighlightPressedButton:(XCActionSheetButton *)button {
    
    [UIView animateWithDuration:0.3f
                     animations:^() {
                         
                         if (self.buttonResponse == XCActionSheetButtonResponseFadesOnPress) {
                             button.alpha = .95f;
                         } else if( self.buttonResponse == XCActionSheetButtonResponseShrinksOnPress) {
                             button.transform = CGAffineTransformMakeScale(1, 1);
                         } else  if (self.buttonResponse == XCActionSheetButtonResponseHighlightsOnPress) {
                             button.backgroundColor = button.originalBackgroundColor;
                             [button setTitleColor:button.originalTextColor forState:UIControlStateAll];
                         } else {
                             UIColor *tempColor = button.backgroundColor;
                             button.backgroundColor = button.titleLabel.textColor;
                             [button setTitleColor:tempColor forState:UIControlStateAll];
                         }
                     }];
    
}

#pragma mark HSActionSheet Helpful methods

- (NSInteger)addButtonWithTitle:(NSString *)title {

    NSInteger index = self.buttons.count - 1;
    
    XCActionSheetButton *button = [[XCActionSheetButton alloc] initWithBottomCornersRounded];
    [button setTitle:title forState:UIControlStateAll];
    button.index = index;
    
    if (self.hasCancelButton) {
        
        [self.buttons insertObject:button atIndex:index];
        [[self.buttons lastObject] setIndex:self.buttons.count - 1];
        
        XCActionSheetButton *tempButton;
        XCActionSheetButton *theButtonToCopy;
        
        if (self.buttons.count == 3) {
            if (self.titleView) {
                tempButton = [[XCActionSheetButton alloc] init];
            } else {
                tempButton = [[XCActionSheetButton alloc] initWithTopCornersRounded];
            }
        
            theButtonToCopy = [self.buttons objectAtIndex:0];
            tempButton.index = theButtonToCopy.index;
            [tempButton setTitle:theButtonToCopy.titleLabel.text forState:UIControlStateAll];
            
            [self.buttons replaceObjectAtIndex:0 withObject:tempButton];
            [self setButtonTextColor:theButtonToCopy.titleLabel.textColor forButtonAtIndex:0];
            [self setButtonBackgroundColor:theButtonToCopy.backgroundColor forButtonAtIndex:0];

        } else {
           
            tempButton = [[XCActionSheetButton alloc] init];
            theButtonToCopy = [self.buttons objectAtIndex:(index - 1)];
            [tempButton setTitle:theButtonToCopy.titleLabel.text forState:UIControlStateAll];
            tempButton.titleLabel.text = theButtonToCopy.titleLabel.text;
            
            [self.buttons replaceObjectAtIndex:(index - 1) withObject:tempButton];
            [self setButtonTextColor:theButtonToCopy.titleLabel.textColor forButtonAtIndex:(index - 1)];
            [self setButtonBackgroundColor:theButtonToCopy.backgroundColor forButtonAtIndex:(index - 1)];
        }
    } else {
        [self.buttons addObject:button];
    }
    
    [self setUpTheActions];
    [self setUpTheActionSheet];
    
    return index;
}


- (void)buttonClicked:(XCActionSheetButton *)button {
    
    [self.delegate actionSheet:self clickedButtonAtIndex:button.index];
    self.shouldCancelOnTouch = YES;
    [self removeFromView];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    
    if (!animated) {
        [self.transparentView removeFromSuperview];
        [self removeFromSuperview];
        self.visHSle = NO;
        [self.delegate actionSheet:self clickedButtonAtIndex:buttonIndex];
    } else {
        [self removeFromView];
        [self.delegate actionSheet:self clickedButtonAtIndex:buttonIndex];
    }
}

- (void)showInView:(UIView *)theView {
    
    [theView addSubview:self];
    [theView insertSubview:self.transparentView belowSubview:self];
    
    CGRect theScreenRect = [UIScreen mainScreen].bounds;
    
    float height;
    float x;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        height = CGRectGetHeight(theScreenRect);
        x = CGRectGetWidth(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetWidth(theScreenRect), CGRectGetHeight(theScreenRect));
    } else {
        height = CGRectGetWidth(theScreenRect);
        x = CGRectGetHeight(theView.frame) / 2.0;
        self.transparentView.frame = CGRectMake(self.transparentView.center.x, self.transparentView.center.y, CGRectGetHeight(theScreenRect), CGRectGetWidth(theScreenRect));
    }
    
    self.center = CGPointMake(x, height + CGRectGetHeight(self.frame) / 2.0);
    self.transparentView.center = CGPointMake(x, height / 2.0);
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^() {
                         self.transparentView.alpha = 0.4f;
                         if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
                             self.center = CGPointMake(x, (height - 20) - CGRectGetHeight(self.frame) / 2.0);
                         } else {
                             self.center = CGPointMake(x, height - CGRectGetHeight(self.frame) / 2.0 - 70);
                         }
                         
                     } completion:^(BOOL finished) {
                         self.visHSle = YES;
                     }];
}

- (void)removeFromView {
    
    if (self.shouldCancelOnTouch) {
        
        [UIView animateWithDuration:0.3f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^() {
                             self.transparentView.alpha = 0.0f;
                             self.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0, CGRectGetHeight([UIScreen mainScreen].bounds) + CGRectGetHeight(self.frame) / 2.0);
                         } completion:^(BOOL finished) {
                             [self.transparentView removeFromSuperview];
                             [self removeFromSuperview];
                             self.visHSle = NO;
                         }];
    }
}

//- (void)rotateToCurrentOrientation {
//    
//    float width;
//    float height;
//    
//    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
//        
//        width = CGRectGetWidth([UIScreen mainScreen].bounds);
//        height = CGRectGetHeight([UIScreen mainScreen].bounds);
//        
//        
//            for (XCActionSheetButton * button in self.buttons) {
//                [button resizeForPortraitOrientation];
//            }
//        
//            [self.titleView resizeForPortraitOrientation];
//            [self setUpTheActionSheet];
//        
//    } else {
//        
//        width = CGRectGetHeight([UIScreen mainScreen].bounds);
//        height = CGRectGetWidth([UIScreen mainScreen].bounds);
//
//        for (XCActionSheetButton * button in self.buttons) {
//            [button resizeForLandscapeOrientation];
//        }
//        [self.titleView resizeForLandscapeOrientation];
//        [self setUpTheActionSheet];
//        
//        
//    }
//    
//    self.transparentView.frame  = CGRectMake(0, 0, width, height);
//    self.transparentView.center = CGPointMake(width / 2.0, height / 2.0);
//    self.center = self.center   = CGPointMake(width / 2.0, height - CGRectGetHeight(self.frame) / 2.0);
//    
//}

#pragma mark HSActionSheet Color methods

- (void)setButtonTextColor:(UIColor *)color {
    
    for (XCActionSheetButton *button in self.buttons) {
            [button setTitleColor:color forState:UIControlStateAll];
        button.originalTextColor = color;
    }
    
    [self setTitleTextColor:color];
}

- (void)setButtonBackgroundColor:(UIColor *)color {
    
    for (XCActionSheetButton *button in self.buttons) {
        button.backgroundColor = color;
        button.originalBackgroundColor = color;
    }

    [self setTitleBackgroundColor:color];
}

- (void)setTitleTextColor:(UIColor *)color {
    self.titleView.titleLabel.textColor = color;
}

- (void)setTitleBackgroundColor:(UIColor *)color {
    self.titleView.backgroundColor = color;
}

- (void)setTextColor:(UIColor *)color ForButton:(XCActionSheetButton *)button {
    [button setTitleColor:color forState:UIControlStateAll];
}

- (void)setButtonBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index {
    [[self.buttons objectAtIndex:index] setBackgroundColor:color];
}

- (void)setButtonTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index {
    [self setTextColor:color ForButton:[self.buttons objectAtIndex:index]];
}

- (UIColor *)buttonBackgroundColorAtIndex:(NSInteger)index {
    return [[self.buttons objectAtIndex:index] backgroundColor];
}

- (UIColor *)buttonTextColorAtIndex:(NSInteger)index {
    return [[[self.buttons objectAtIndex:index] titleLabel] textColor];
}

- (void)setButtonHighlightBackgroundColor:(UIColor *)color {
    for (XCActionSheetButton *button in self.buttons) {
        button.highlightBackgroundColor = color;
    }
}

- (void)setButtonHighlightBackgroundColor:(UIColor *)color forButtonAtIndex:(NSInteger)index {
    [[self.buttons objectAtIndex:index] setHighlightBackgroundColor:color];
}

- (void)setButtonHighlightTextColor:(UIColor *)color {
    for (XCActionSheetButton *button in self.buttons) {
        button.highlightTextColor = color;
    }
}

- (void)setButtonHighlightTextColor:(UIColor *)color forButtonAtIndex:(NSInteger)index {
    [[self.buttons objectAtIndex:index] setHighlightTextColor:color];
}

#pragma mark HSActionSheet Other Properties methods

- (void)setTitle:(NSString *)title {
    self.titleView = [[HSActionSheetTitleView alloc] initWithTitle:title];
    [self setUpTheActionSheet];
}

- (NSString *)buttonTitleAtIndex:(NSInteger)index {
    return [[[self.buttons objectAtIndex:index] titleLabel] text];
}

- (NSInteger)numberOfButtons {
    return self.buttons.count;
}

- (void)setFont:(UIFont *)font {
    for (XCActionSheetButton *button in self.buttons) {
        [self setFont:font forButton:button];
    }
    
    [self setTitleFont:font];
}

- (void)setFont:(UIFont *)font forButtonAtIndex:(NSInteger)index {
    [[[self.buttons objectAtIndex:index] titleLabel] setFont:font];
}

- (void)setFont:(UIFont *)font forButton:(XCActionSheetButton *)button {
    button.titleLabel.font = font;
}

- (void)setTitleFont:(UIFont *)font {
    if (self.titleView) {
        self.titleView.titleLabel.font = font;
    }
}

@end


/*************************************************    XCActionSheetButton   ************************************************************/
#pragma mark - XCActionSheetButton

@implementation XCActionSheetButton


- (id)init {
    
    float width;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
    }
    self = [self initWithFrame:CGRectMake(0, 0, width - 16, 44)];
    
    self.backgroundColor = [UIColor whiteColor];
    self.originalBackgroundColor = self.backgroundColor;
    self.titleLabel.font = [UIFont systemFontOfSize:21];
    [self setTitleColor:TestBlueColor forState:UIControlStateAll];
    self.originalTextColor = TestBlueColor;
    
    self.alpha = 0.95f;
    
    self.cornerType = XCActionSheetButtonCornerTypeNoCornersRounded;
    
    return self;
}

- (id)initWithTopCornersRounded {
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    self.cornerType = XCActionSheetButtonCornerTypeTopCornersRounded;
    return self;
}

- (id)initWithBottomCornersRounded {
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.cornerType = XCActionSheetButtonCornerTypeBottomCornersRounded;
    return self;
}

- (id)initWithAllCornersRounded {
    self = [self init];
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
    self.cornerType = XCActionSheetButtonCornerTypeAllCornersRounded;
    return self;
}


- (void)setTextColor:(UIColor *)color {
    [self setTitleColor:color forState:UIControlStateAll];
}

- (void)resizeForPortraitOrientation {
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    
    switch (self.cornerType) {
        case XCActionSheetButtonCornerTypeNoCornersRounded:
            break;
            
        case XCActionSheetButtonCornerTypeTopCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
            break;
        }
        case XCActionSheetButtonCornerTypeBottomCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        case XCActionSheetButtonCornerTypeAllCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        default:
            break;
    }
}

- (void)resizeForLandscapeOrientation {
    self.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    
    switch (self.cornerType) {
        case XCActionSheetButtonCornerTypeNoCornersRounded:
            break;
            
        case XCActionSheetButtonCornerTypeTopCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
            break;
        }
        case XCActionSheetButtonCornerTypeBottomCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        case XCActionSheetButtonCornerTypeAllCornersRounded: {
            [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight | UIRectCornerBottomLeft | UIRectCornerBottomRight];
            break;
        }
            
        default:
            break;
    }

}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(4.0, 4.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}
@end


/*************************************************    HSActionSheetTitleView   ************************************************************/
#pragma mark - HSActionSheetTitleView

@implementation HSActionSheetTitleView

- (id)initWithTitle:(NSString *)title {
    
    self = [self init];
    
    float width;
    float labelBuffer;
    
    if (UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])) {
        width = CGRectGetWidth([UIScreen mainScreen].bounds);
        labelBuffer = 44;
    } else {
        width = CGRectGetHeight([UIScreen mainScreen].bounds);
        labelBuffer = 24;
    }
    
    self.alpha = .95f;
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width - labelBuffer, 44)];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.textColor = [UIColor colorWithWhite:0.564 alpha:1.000];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.text = title;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    [self.titleLabel sizeToFit];
    
   
    
    if ((CGRectGetHeight(self.titleLabel.frame) + 30) < 44) {
        self.frame = CGRectMake(0, 0, width - 16, 44);
    } else {
        self.frame = CGRectMake(0, 0, width - 16, CGRectGetHeight(self.titleLabel.frame) + 30);
    }
    
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    [self addSubview:self.titleLabel];
    self.titleLabel.center = self.center;
    
    return self;
}

- (void)resizeForPortraitOrientation {
    
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) - 24, 44);
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)resizeForLandscapeOrientation {
    
    self.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 16, CGRectGetHeight(self.frame));
    self.titleLabel.frame = CGRectMake(0, 0, CGRectGetHeight([UIScreen mainScreen].bounds) - 44, 44);
    [self setMaskTo:self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)setMaskTo:(UIView*)view byRoundingCorners:(UIRectCorner)corners
{
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(4.0, 4.0)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    view.layer.mask = shape;
}

@end
