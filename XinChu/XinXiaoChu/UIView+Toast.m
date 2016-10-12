//
//  UIView+Toast.m
//  XinXiaoChu
//
//  Created by 海尔智能-李松 on 16/7/25.
//  Copyright © 2016年 海尔智能-李松. All rights reserved.
//

#import "UIView+Toast.h"

static const CGFloat XCToastMaxWidth            = 0.8;      // 80% of parent view width

static const CGFloat XCToastMaxHeight           = 0.8;      // 80% of parent view height

static const CGFloat XCToastHorizontalPadding   = 10.0;

static const CGFloat XCToastVerticalPadding     = 10.0;

static const CGFloat XCToastCornerRadius        = 4.0;

static const CGFloat XCToastOpacity             = 1.0;

static const CGFloat XCToastFontSize            = 15.0;

static const CGFloat XCToastMaxTitleLines       = 0;

static const CGFloat XCToastMaxMessageLines     = 0;

static const CGFloat XCToastFadeDuration        = 0.1;

// display duration and position

static const CGFloat XCToastDefaultDuration     = 1.5;

static const NSString * XCToastDefaultPosition  = @"bottom";

// image view size

static const CGFloat XCToastImageViewWidth      = 80.0;

static const CGFloat XCToastImageViewHeight     = 80.0;


static const NSString * XCToastActivityDefaultPosition = @"center";

static const NSString * XCToastActivityViewKey  = @"XCToastActivityViewKey";


@implementation UIView (Toast)

#pragma mark - Toast Methods

- (void)makeToastOnWindow:(NSString *)message

{
    
    UIView *toast=[self viewForMessage:message title:nil image:nil];
    
    [self showToastOnWindow:toast duration:XCToastDefaultDuration position:XCToastDefaultPosition];
    
}

- (void)showToastOnWindow:(UIView *)toast duration:(CGFloat)interval position:(id)point {
    
    toast.center = [self centerPointForPosition:point withToast:toast];
    
    toast.alpha = 0.0;
    
    UIViewController *vc = [self appRootViewController];
    
    [vc.view addSubview:toast];
    
    
    
    [UIView animateWithDuration:XCToastFadeDuration
     
                         delay:0.0
     
                       options:UIViewAnimationOptionCurveEaseOut
     
                    animations:^{
                        
                        toast.alpha = 1.0;
                        
                    } completion:^(BOOL finished) {
                        
                        [UIView animateWithDuration:XCToastFadeDuration
                         
                                              delay:interval
                         
                                            options:UIViewAnimationOptionCurveEaseIn
                         
                                         animations:^{
                                             
                                             toast.alpha = 0.0;
                                             
                                         } completion:^(BOOL finished) {
                                             
                                             [toast removeFromSuperview];
                                             
                                         }];
                        
                    }];
    
}

- (UIViewController *)appRootViewController

{
    
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *topVC = appRootVC;
    
    while (topVC.presentedViewController) {
        
        topVC = topVC.presentedViewController;
        
    }
    
    return topVC;
    
}

- (void)makeToast:(NSString *)message {
    
    [self makeToastOnWindow:message];
    
}



#pragma mark - Private Methods

- (CGPoint)centerPointForPosition:(id)point withToast:(UIView *)toast {
    
    if([point isKindOfClass:[NSString class]]) {
        
        // convert string literals @"top", @"bottom", @"center", or any point wrapped in an NSValue object into a CGPoint
        
        if([point caseInsensitiveCompare:@"top"] == NSOrderedSame) {
            
            return CGPointMake(self.bounds.size.width/2, (toast.frame.size.height / 2) + XCToastVerticalPadding);
            
        } else if([point caseInsensitiveCompare:@"bottom"] == NSOrderedSame) {
            
            return CGPointMake(self.bounds.size.width/2, (self.bounds.size.height - (toast.frame.size.height / 2)) - XCToastVerticalPadding - 100);
            
        } else if([point caseInsensitiveCompare:@"center"] == NSOrderedSame) {
            
            return  CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            
        }
        
    } else if ([point isKindOfClass:[NSValue class]]) {
        
        return [point CGPointValue];
        
    }
    
    
    
    NSLog(@"Warning: Invalid position for toast.");
    
    return [self centerPointForPosition:XCToastDefaultPosition withToast:toast];
    
}

- (UIView *)viewForMessage:(NSString *)message title:(NSString *)title image:(UIImage *)image {
    
    // sanity
    
    if((message == nil) && (title == nil) && (image == nil)) return nil;
    
    
    
    // dynamically build a toast view with any combination of message, title, & image.
    
    UILabel *messageLabel = nil;
    
    UILabel *titleLabel = nil;
    
    UIImageView *imageView = nil;
    
    
    
    // create the parent view
    
    UIView *wrapperView = [[UIView alloc] init];
    
    wrapperView.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin);
    
    wrapperView.layer.cornerRadius = XCToastCornerRadius;
    
    wrapperView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:XCToastOpacity];
    
    
    
    if(image != nil) {
        
        imageView = [[UIImageView alloc] initWithImage:image];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        imageView.frame = CGRectMake(XCToastHorizontalPadding, XCToastVerticalPadding, XCToastImageViewWidth, XCToastImageViewHeight);
        
    }
    
    CGFloat imageWidth, imageHeight, imageLeft;
    
    // the imageView frame values will be used to size & position the other views
    
    if(imageView != nil) {
        
        imageWidth = imageView.bounds.size.width;
        
        imageHeight = imageView.bounds.size.height;
        
        imageLeft = XCToastHorizontalPadding;
        
    } else {
        
        imageWidth = imageHeight = imageLeft = 0.0;
        
    }
    
    
    
    if (title != nil) {
        
        titleLabel = [[UILabel alloc] init];
        
        titleLabel.numberOfLines = XCToastMaxTitleLines;
        
        titleLabel.font = [UIFont boldSystemFontOfSize:XCToastFontSize];
        
        titleLabel.textAlignment = NSTextAlignmentLeft;
        
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        titleLabel.textColor = [UIColor whiteColor];
        
        titleLabel.backgroundColor = [UIColor clearColor];
        
        titleLabel.alpha = 1.0;
        
        titleLabel.text = title;
        
        
        
        // size the title label according to the length of the text
        
        CGSize maxSizeTitle = CGSizeMake((self.bounds.size.width * XCToastMaxWidth) - imageWidth, self.bounds.size.height * XCToastMaxHeight);
        
        CGSize expectedSizeTitle = [title sizeWithFont:titleLabel.font constrainedToSize:maxSizeTitle lineBreakMode:titleLabel.lineBreakMode];
        
        titleLabel.frame = CGRectMake(0.0, 0.0, expectedSizeTitle.width, expectedSizeTitle.height);
        
    }
    
    
    
    if (message != nil) {
        
        messageLabel = [[UILabel alloc] init];
        
        messageLabel.numberOfLines = XCToastMaxMessageLines;
        
        messageLabel.font = [UIFont systemFontOfSize:XCToastFontSize];
        
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        
        messageLabel.textColor = [UIColor whiteColor];
        
        messageLabel.backgroundColor = [UIColor clearColor];
        
        messageLabel.alpha = 1.0;
        
        messageLabel.text = message;
        
        
        
        // size the message label according to the length of the text
        
        CGSize maxSizeMessage = CGSizeMake((self.bounds.size.width * XCToastMaxWidth) - imageWidth, self.bounds.size.height * XCToastMaxHeight);
        
        CGSize expectedSizeMessage = [message sizeWithFont:messageLabel.font constrainedToSize:maxSizeMessage lineBreakMode:messageLabel.lineBreakMode];
        
        messageLabel.frame = CGRectMake(0.0, 0.0, expectedSizeMessage.width, expectedSizeMessage.height);
        
    }
    
    
    
    // titleLabel frame values
    
    CGFloat titleWidth, titleHeight, titleTop, titleLeft;
    
    
    
    if(titleLabel != nil) {
        
        titleWidth = titleLabel.bounds.size.width;
        
        titleHeight = titleLabel.bounds.size.height;
        
        titleTop = XCToastVerticalPadding;
        
        titleLeft = imageLeft + imageWidth + XCToastHorizontalPadding;
        
    } else {
        
        titleWidth = titleHeight = titleTop = titleLeft = 0.0;
        
    }
    
    
    
    // messageLabel frame values
    
    CGFloat messageWidth, messageHeight, messageLeft, messageTop;
    
    
    
    if(messageLabel != nil) {
        
        messageWidth = messageLabel.bounds.size.width;
        
        messageHeight = messageLabel.bounds.size.height;
        
        messageLeft = imageLeft + imageWidth + XCToastHorizontalPadding;
        
        messageTop = titleTop + titleHeight + XCToastVerticalPadding;
        
    } else {
        
        messageWidth = messageHeight = messageLeft = messageTop = 0.0;
        
    }
    
    
    
    
    
    CGFloat longerWidth = MAX(titleWidth, messageWidth);
    
    CGFloat longerLeft = MAX(titleLeft, messageLeft);
    
    
    
    // wrapper width uses the longerWidth or the image width, whatever is larger. same logic applies to the wrapper height
    
    CGFloat wrapperWidth = MAX((imageWidth + (XCToastHorizontalPadding * 2)), (longerLeft + longerWidth + XCToastHorizontalPadding));
    
    CGFloat wrapperHeight = MAX((messageTop + messageHeight + XCToastVerticalPadding), (imageHeight + (XCToastVerticalPadding * 2)));
    
    
    
    wrapperView.frame = CGRectMake(0.0, 0.0, wrapperWidth, wrapperHeight);
    
    
    
    if(titleLabel != nil) {
        
        titleLabel.frame = CGRectMake(titleLeft, titleTop, titleWidth, titleHeight);
        
        [wrapperView addSubview:titleLabel];
        
    }
    
    
    
    if(messageLabel != nil) {
        
        messageLabel.frame = CGRectMake(messageLeft, messageTop, messageWidth, messageHeight);
        
        [wrapperView addSubview:messageLabel];
        
    }
    
    
    
    if(imageView != nil) {
        
        [wrapperView addSubview:imageView];
        
    }
    
    
    
    return wrapperView;
    
}

@end
