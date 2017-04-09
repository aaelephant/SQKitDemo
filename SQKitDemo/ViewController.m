//
//  ViewController.m
//  SQKitDemo
//
//  Created by qbshen on 2017/4/9.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "ViewController.h"
#import "SQTableViewDelegate.h"

@interface ViewController ()

//唯一一个地方强引用
@property (nonatomic, strong) SQTableViewDelegate * delegate;
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

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




@end
