//
//  RMLTabBarViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/24.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLTabBarViewController.h"
#import "RMLEssenceViewController.h"
#import "RMLNewViewController.h"
#import "RMLFriendTrendsViewController.h"
#import "RMLMeViewController.h"
#import "RMLTabBar.h"
#import "RMLNavigationViewController.h"

@interface RMLTabBarViewController ()

@end

@implementation RMLTabBarViewController


/**
 * 当第一次使用这个类的时候会调用一次
 */
+ (void)initialize{
    
    //设置tabbar字体和渲染
    [UINavigationBar appearance];
    NSMutableDictionary *arrs = [NSMutableDictionary dictionary];
    arrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    arrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedArrs = [NSMutableDictionary dictionary];
    selectedArrs[NSFontAttributeName] = arrs[NSFontAttributeName];
    selectedArrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:arrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedArrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpChildVc:[[RMLEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    
    [self setUpChildVc:[[RMLNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    
    [self setUpChildVc:[[RMLFriendTrendsViewController alloc
                        ] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    
    [self setUpChildVc:[[RMLMeViewController alloc
                         ] init] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
  //用自定义的tabbar
    [self setValue:[[RMLTabBar alloc] init] forKeyPath:@"tabBar"];
}



/**
   设置子控制器方法
 */
- (void)setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{

    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    RMLNavigationViewController *nav = [[RMLNavigationViewController alloc] initWithRootViewController:vc];
    [self addChildViewController:nav];
}

@end
