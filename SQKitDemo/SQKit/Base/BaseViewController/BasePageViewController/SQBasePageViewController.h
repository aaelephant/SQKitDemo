//
//  SNBaseViewController.h
//  soccernotes
//
//  Created by sqb on 15/6/25.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

//#import "ViewController.h"
#import "BaseBackForResultDelegate.h"
#import "SQTableViewDelegate.h"
#import "SQKeyboardTool.h"


@interface SQBasePageViewController : UIViewController

@property (nonatomic) UITableView *tableView;
@property (nonatomic) SQKeyboardTool * keyTool;
@property (nonatomic) SQTableViewDelegate * tableDelegate;
@property (nonatomic) NSMutableDictionary * originDic;
@property (nonatomic) id createArgs;
@property (nonatomic) id backArgs;
@property (nonatomic, weak) id<BaseBackForResultDelegate> backDelegate;
@property (nonatomic) NSInteger backCode;

+ (instancetype)createViewController:(id)createArgs;
- (void)initTitleBar;
- (void)initTableView;
- (void)requestInfo;
- (void)updateTableView;

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

@end
