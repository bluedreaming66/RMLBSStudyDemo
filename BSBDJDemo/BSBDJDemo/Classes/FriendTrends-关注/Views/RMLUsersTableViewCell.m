//
//  RMLUsersTableViewCell.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/29.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLUsersTableViewCell.h"
#import "RMLUserModel.h"
#import <UIImageView+WebCache.h>
@interface RMLUsersTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;


@end

@implementation RMLUsersTableViewCell


- (void)setUserModel:(RMLUserModel *)userModel{
    _userModel = userModel;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:userModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",userModel.screen_name];
    self.numLabel.text = [NSString stringWithFormat:@"%ld人关注",(long)userModel.fans_count];
}

@end
