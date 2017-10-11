//
//  RMLTabBar.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/24.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLTabBar.h"

@interface RMLTabBar ()

@property (nonatomic, weak) UIButton *publishBtn;

@end

@implementation RMLTabBar

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        self.backgroundImage = [UIImage imageNamed:@"tabbar-light"];
        
        UIButton *publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [self addSubview:publishBtn];
        self.publishBtn = publishBtn;
        
    }
    return self;
}



/**
 重新布局 tabbar 子控件
 */
- (void)layoutSubviews{

    [super layoutSubviews];
    self.publishBtn.bounds = CGRectMake(0, 0, self.publishBtn.currentBackgroundImage.size.width, self.publishBtn.currentBackgroundImage.size.height);
    self.publishBtn.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
    CGFloat btnY = 0;
    CGFloat btnW = self.width /5;
    CGFloat btnH = self.height;
    NSInteger index = 0;
    
    for (UIView *view in self.subviews ) {
        if (![view isKindOfClass:[UIControl class]] || view == self.publishBtn) continue;
        
        CGFloat btnX = btnW * (index > 1 ? (index + 1) : index );
        view.frame = CGRectMake(btnX, btnY, btnW, btnH);
        index ++ ;
    }
}



@end
