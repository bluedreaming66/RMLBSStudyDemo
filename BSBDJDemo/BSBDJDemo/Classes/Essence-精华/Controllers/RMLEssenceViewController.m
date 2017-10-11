//
//  RMLEssenceViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/24.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLEssenceViewController.h"

@interface RMLEssenceViewController ()

@end

@implementation RMLEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlighImage:@"MainTagSubIconClick" target:self action:@selector(leftBtnClick)];
    
    self.view.backgroundColor = RMLGlobalBg;
    
}


- (void)leftBtnClick{
  
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = [UIColor yellowColor];
    [self.navigationController pushViewController:vc animated:YES];
    
}


@end
