//
//  RMLListTableViewCell.m
//  BSBDJDemo
//
//  Created by blue on 2017/9/25.
//  Copyright © 2017年 blue. All rights reserved.
//

#import "RMLListTableViewCell.h"
#import "RMLListModel.h"

@interface RMLListTableViewCell() 
@property (weak, nonatomic) IBOutlet UIView *selectedView;

@end

@implementation RMLListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = RMLRGBColor(244, 244, 244);
    self.selectedView.backgroundColor = RMLRGBColor(219, 21, 26);
}

- (void)layoutSubviews{
    [super layoutSubviews];

    self.textLabel.y = 2;
    self.textLabel.height = self.height - 2 * self.textLabel.y;
}

- (void)setListModel:(RMLListModel *)listModel{
  
    _listModel = listModel;
    self.textLabel.text = listModel.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.selectedView.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedView.backgroundColor : RMLRGBColor(78, 78, 78);
   
}



@end
