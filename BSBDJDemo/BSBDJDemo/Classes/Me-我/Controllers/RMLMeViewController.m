//
//  RMLMeViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/24.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLMeViewController.h"

@interface RMLMeViewController ()

@end

@implementation RMLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    UIBarButtonItem *setItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlighImage:@"mine-setting-icon-click" target:self action:@selector(setBtnClick)];
    UIBarButtonItem *nightItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlighImage:@"mine-moon-icon-click" target:self action:@selector(nightModeBtnClick)];
    self.navigationItem.rightBarButtonItems = @[setItem,nightItem];
    
    self.view.backgroundColor = RMLGlobalBg;
}

- (void)setBtnClick{

}

- (void)nightModeBtnClick{

}

@end
