//
//  ATableCell.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/10.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "ATableCell.h"
#import "SQCellViewModel.h"

@implementation ATableCell

-(void)fillData:(SQBaseTableViewInfo *)info
{
    self.textLabel.text = [info.args name];
}

@end
