//
//  SQSectionViewModel.h
//  SQKitDemo
//
//  Created by qbshen on 2017/4/10.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "SQBaseViewModel.h"
#import "SQCellViewModel.h"

@interface SQSectionViewModel : SQBaseViewModel

@property (nonatomic, strong) NSArray<SQCellViewModel*> * cellViewModels;

@end
