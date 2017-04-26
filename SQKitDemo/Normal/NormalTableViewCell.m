//
//  NormalTableViewCell.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/26.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "NormalTableViewCell.h"
#import "SQCellViewModel.h"

@implementation NormalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(void)fillData:(SQCellViewModel*)info
{
    self.textLabel.text = [info name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
