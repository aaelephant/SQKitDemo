//
//  NormalViewController.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/12.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "NormalViewController.h"
#import "SQSectionViewModel.h"
#import "NormalTableViewCell.h"

@interface NormalViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * gTableView;

//@property (nonatomic, strong) NSMutableDictionary * gOriginDic;

@property (nonatomic, strong) NSArray * gDataArray;

@end

@implementation NormalViewController

@viewController(NSStringFromClass([NormalViewController class]),NSStringFromClass([NormalViewController class]))

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self requestInfo];
    
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    //    self.tableView.bounds = self.view.bounds;
    //    self.tableView.center = self.view.center;
}

-(void)initTableView
{
    if (!self.gTableView) {
        self.gTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        self.gTableView.delegate = self;
        self.gTableView.dataSource = self;
        [self.view addSubview:self.gTableView];
    }
}

-(void)requestInfo
{
//    if (!self.gOriginDic) {
//        self.gOriginDic = [NSMutableDictionary new];
//    }
//    NSArray* testSectionData = [self testSectionData];
//    for (SQSectionViewModel* cur in testSectionData) {
//        self.gOriginDic[@([testSectionData indexOfObject:cur])] = [WVRRouterDispatcher dispatchSection:cur.uid args:cur];
//    }
    self.gDataArray = [self testCellData];
    [self updateTableView];
}

-(void)updateTableView
{
//    kWeakSelf(self);
//    [self.delegate loadData:^NSDictionary *{
//        return weakself.originDic;
//    }];
    [self.gTableView reloadData];
}

#pragma UITableViewDelegate DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.gDataArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NormalTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NormalTableViewCell class])];
    if (!cell) {
        cell = [[NormalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([NormalTableViewCell class])];
    }
//    SQTableViewSectionInfo * sectionInfo = self.gOriginDic[@(indexPath.section)];
//    SQBaseTableViewInfo * cellInfo = [sectionInfo cellDataArray][indexPath.row];
    SQCellViewModel * model = self.gDataArray[indexPath.row];
    [cell fillData:model];
    
    return cell;
}

-(NSArray*)testSectionData
{
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < 10; i++) {
        SQSectionViewModel * vModel = [SQSectionViewModel new];
        vModel.uid = @"a";
        vModel.name = [NSString stringWithFormat:@"i am %d %@",i,[vModel class]];
        vModel.cellViewModels = [self testCellData];
        [array addObject:vModel];
    }
    return array;
}

-(NSArray<SQCellViewModel*>*)testCellData
{
    NSMutableArray * array = [NSMutableArray new];
    for (int i = 0; i < 3; i++) {
        SQCellViewModel * vModel = [SQCellViewModel new];
        vModel.name = [NSString stringWithFormat:@"i am %d %@",i,[vModel class]];
        [array addObject:vModel];
    }
    return array;
}





@end
