//
//  RMLNavigationViewController.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLNavigationViewController.h"


@implementation RMLNavigationViewController

//当第一次使用这个类时会调用一次

+ (void)initialize{

  //设置导航栏的背景图片
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}

/**
 * 可以在这个方法中拦截所有push进来的控制器
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    //二级页面 才有返回
    if (self.childViewControllers.count > 0) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"返回" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        //按钮左对齐
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        //button点击事件
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        //二级页面tabbar隐藏
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //设置之后再调用父类方法，这样在子控制器中，如果返回按钮有不同，可以重新设置
    [super pushViewController:viewController animated:YES];
}


- (void)back{
    [self popViewControllerAnimated:YES];
}

@end
