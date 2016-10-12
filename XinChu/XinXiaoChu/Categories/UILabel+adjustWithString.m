//
//  UILabel+adjustWithString.m
//  UI36CustomButton
//
//  Created by 李松 on 16/2/24.
//  Copyright © 2016年 mac.李松. All rights reserved.
//

#import "UILabel+adjustWithString.h"

@implementation UILabel (adjustWithString)

- (void)sizeToFitWithText:(NSString *)text
{
    self.adjustsFontSizeToFitWidth = YES;
    
    self.textAlignment = NSTextAlignmentLeft;
    
    self.text = text;
    
    [self sizeToFit];
}

@end
