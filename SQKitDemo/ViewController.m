//
//  ViewController.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/9.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "ViewController.h"
#import "SQTableViewDelegate.h"
#import "WVRRouterDispatcher.h"
#import "SQSectionViewModel.h"

@interface ViewController ()

//唯一一个地方强引用
@property (nonatomic, strong) SQTableViewDelegate * delegate;   //equal to adapter
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableDictionary * originDic;

@end

@implementation ViewController

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
    if (!self.tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        if (!self.delegate) {
            self.delegate = [SQTableViewDelegate new];
        }
        self.tableView.delegate = self.delegate;
        self.tableView.dataSource = self.delegate;
        [self.view addSubview:self.tableView];
    }
}

-(void)requestInfo
{
    if (!self.originDic) {
        self.originDic = [NSMutableDictionary new];
    }
    NSArray* testSectionData = [self testSectionData];
    for (SQSectionViewModel* cur in testSectionData) {
        SQTableViewSectionInfo* sectionInfo = [WVRRouterDispatcher dispatchSection:cur.uid args:cur];
        sectionInfo.viewController = self;
        self.originDic[@([testSectionData indexOfObject:cur])] = sectionInfo;
    }
    [self updateTableView];
}

-(void)updateTableView
{
    kWeakSelf(self);
    [self.delegate loadData:^NSDictionary *{
        return weakself.originDic;
    }];
    [self.tableView reloadData];
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
