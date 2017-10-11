//
//  RMLUserModel.h
//  BSBDJDemo
//
//  Created by blue on 2017/9/29.
//  Copyright © 2017年 blue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMLUserModel : NSObject

@property (nonatomic, assign) NSInteger fans_count;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, copy) NSString *header;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *screen_name;
@property (nonatomic, assign) NSInteger tiezi_count;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) BOOL is_follow;
@property (nonatomic, assign) BOOL is_vip;

@end
