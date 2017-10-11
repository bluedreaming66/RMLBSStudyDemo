//
//  RMLFriendTrendsViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/24.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLFriendTrendsViewController.h"
#import "RMLCommendViewController.h"

@interface RMLFriendTrendsViewController ()

@end

@implementation RMLFriendTrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"我的关注";
  
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlighImage:@"friendsRecommentIcon-click" target:self action:@selector(leftBtnClick)];
    self.view.backgroundColor = RMLGlobalBg;
    
}


- (void)leftBtnClick{
    
    RMLCommendViewController *commendVC = [[RMLCommendViewController alloc] init];
    [self.navigationController pushViewController:commendVC animated:YES];
}

@end
