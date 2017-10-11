//
//  RMLListModel.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLListModel.h"

@implementation RMLListModel

- (NSMutableArray *)users{

    if (!_users) {
        _users = [NSMutableArray array];
    }
    return _users;
}

@end
