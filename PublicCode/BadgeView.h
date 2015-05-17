//
//  BadgeView.h
//  PublicCode
//
//  Created by Damon on 15/5/17.
//  Copyright (c) 2015年 Damon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BadgeView : UIView

@property(nonatomic, assign) NSInteger number;
@property(nonatomic, strong) UIImage *backgroundImage;
//显示数字颜色,默认白色
@property(nonatomic, strong) UIColor *textColor;

- (id)initWithBackgroundImage:(UIImage *)image;
- (void)setNumber:(NSInteger)number prefix:(NSString *)prefix;

@end
