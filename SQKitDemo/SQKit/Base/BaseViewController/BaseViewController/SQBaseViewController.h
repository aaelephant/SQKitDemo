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
#import "SQCollectionViewDelegate.h"
#import "SQKeyboardTool.h"


@interface SQBaseViewController : UIViewController<BaseBackForResultDelegate>

@property (nonatomic) UITableView *tableView;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) SQKeyboardTool * keyTool;
@property (nonatomic) SQTableViewDelegate * tableDelegate;
@property (nonatomic) SQCollectionViewDelegate * collectionDelegate;
@property (nonatomic) NSMutableDictionary * originDic;
@property (nonatomic) NSMutableDictionary * collectionVOriginDic;
@property (nonatomic) NSMutableDictionary * tableVOriginDic;
@property (nonatomic) NSArray * cellNibNames;
@property (nonatomic) NSArray * cellClassNames;
@property (nonatomic) NSArray * headerNibNames;
@property (nonatomic) NSArray * headerClassNames;
@property (nonatomic) NSArray * footerNibNames;
@property (nonatomic) NSArray * footerClassNames;
@property (nonatomic) id createArgs;
@property (nonatomic) id<BaseBackForResultDelegate> backDelegate;
@property (nonatomic) id backArgs;
@property (nonatomic) NSInteger backCode;

+ (instancetype)createViewController:(id)createArgs;
- (void)initTitleBar;
- (void)initTableView;
-(void)initCollectionView;
- (void)requestInfo;
- (void)updateTableView;
-(void)updateCollectionView;
- (void)phoneButtonItem;
- (void)shareBtnItem;

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

//-(void)showNullView:(UIView*)parentV title:(NSString*)title icon:(NSString*)icon;
//-(void)removeNullView;
//-(void)showNetErrorV:(UIView*)parentV reloadBlock:(void(^)())reloadBlock ;
//-(void)removeNetErrorV;

@property (nonatomic) BOOL hidenStatusBar;
@end
