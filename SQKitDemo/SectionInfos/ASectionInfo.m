//
//  ASectionInfo.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/10.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "ASectionInfo.h"
#import "ATableCell.h"
#import "ATableHeaderView.h"
#import "SQSectionViewModel.h"

@implementation ASectionInfo
@synthesize headViewInfo = _headViewInfo;

@section([NSString stringWithFormat:@"a"],NSStringFromClass([ASectionInfo class]))

-(void)dispatch:(SQSectionViewModel*)args
{
    SQTableViewHeadViewInfo * headerInfo = [SQTableViewHeadViewInfo new];
    headerInfo.cellNibName = NSStringFromClass([ATableHeaderView class]);
    headerInfo.cellHeight = 44.f;
    headerInfo.args = args.name;
    
    _headViewInfo = headerInfo;
    
    kWeakSelf(self);
    NSMutableArray * cellArrays = [NSMutableArray new];
    for (SQCellViewModel* vModel in args.cellViewModels) {
        SQTableViewCellInfo * cellInfo = [SQTableViewCellInfo new];
        cellInfo.cellNibName = NSStringFromClass([ATableCell class]);
        cellInfo.cellHeight = 44.f;
        cellInfo.args = vModel;
        cellInfo.gotoNextBlock = ^(SQTableViewCellInfo* args){
            [weakself.viewController.navigationController pushViewController:[WVRRouterDispatcher dispatchController:[args.args gNextPageID] args:nil] animated:YES];
        };
        [cellArrays addObject:cellInfo];
    }
    
    self.cellDataArray = cellArrays;
}

@end
