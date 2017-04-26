//
//  NormalTableViewCell.h
//  SQKitDemo
//
//  Created by qbshen on 2017/4/26.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SQCellViewModel;

@interface NormalTableViewCell : UITableViewCell

-(void)fillData:(SQCellViewModel*)info;

@end
