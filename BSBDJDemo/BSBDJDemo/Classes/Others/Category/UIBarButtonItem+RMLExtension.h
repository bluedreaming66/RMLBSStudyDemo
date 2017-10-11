//
//  UIBarButtonItem+RMLExtension.h
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (RMLExtension)

+ (instancetype)itemWithImage:(NSString *)image highlighImage:(NSString *)highlighImage target:(id)target action:(SEL)action;

@end
