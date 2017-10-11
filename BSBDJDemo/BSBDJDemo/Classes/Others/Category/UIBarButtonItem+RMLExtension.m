//
//  UIBarButtonItem+RMLExtension.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "UIBarButtonItem+RMLExtension.h"

@implementation UIBarButtonItem (RMLExtension)

+ (instancetype)itemWithImage:(NSString *)image highlighImage:(NSString *)highlighImage target:(id)target action:(SEL)action{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlighImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
