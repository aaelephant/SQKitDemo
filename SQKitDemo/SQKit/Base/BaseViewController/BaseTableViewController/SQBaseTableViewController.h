//
//  SNBaseTableViewController.h
//  soccernotes
//
//  Created by sqb on 15/6/26.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBackForResultDelegate.h"
#import "SQTableViewDelegate.h"
#import "SQKeyboardTool.h"
#import "SQDefine.h"

@interface SQBaseTableViewController : UITableViewController<BaseBackForResultDelegate>

@property (nonatomic) SQKeyboardTool * keyTool;
@property (nonatomic) SQTableViewDelegate * tableDelegate;
@property (nonatomic) NSMutableDictionary * originDic;

@property (nonatomic) id createArgs;
@property (nonatomic, weak) id<BaseBackForResultDelegate> backDelegate;
@property (nonatomic) id backArgs;
@property (nonatomic) NSInteger backCode;

+ (instancetype)createViewController:(id)createArgs;
- (void)initTitleBar;
- (void)initTableView;
- (void)requestInfo;
- (void)updateTableView;
- (void)shareBtnItem;
- (void)defaultBackButtonItem;

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

- (void)backForResult:(id)info resultCode:(NSInteger)resultCode;
- (void)showNullView:(UIView*)parentV title:(NSString*)title icon:(NSString*)icon;
- (void)removeNullView;
- (void)showNetErrorV:(UIView*)parentV reloadBlock:(void(^)())reloadBlock ;
- (void)removeNetErrorV;

@end

