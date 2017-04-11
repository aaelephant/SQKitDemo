//
//  ATableHeaderView.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/10.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "ATableHeaderView.h"

@interface ATableHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *titleL;

@end
@implementation ATableHeaderView

-(void)fillData:(SQBaseTableViewInfo *)info
{
    self.titleL.text = info.args;
}

@end
