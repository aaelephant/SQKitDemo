//
//  SQBaseCollectionViewController.h
//  youthGo
//
//  Created by qbshen on 16/6/14.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQCollectionViewDelegate.h"
#import "BaseBackForResultDelegate.h"
#import "SQKeyboardTool.h"

@interface SQBaseCollectionViewController : UICollectionViewController<BaseBackForResultDelegate>

@property (nonatomic) SQKeyboardTool * keyTool;
@property (nonatomic) SQCollectionViewDelegate * collectionDelegate;
@property (nonatomic) NSMutableDictionary * originDic;
@property (nonatomic) NSArray * cellNibNames;
@property (nonatomic) NSArray * cellClassNames;
@property (nonatomic) NSArray * headerNibNames;
@property (nonatomic) NSArray * headerClassNames;
@property (nonatomic) NSArray * footerNibNames;
@property (nonatomic) NSArray * footerClassNames;
@property (nonatomic) id createArgs;
@property (nonatomic, weak) id<BaseBackForResultDelegate> backDelegate;
@property (nonatomic) id backArgs;
@property (nonatomic) NSInteger backCode;

+ (instancetype)createViewController:(id)createArgs;
- (void)initTitleBar;
- (void)initCollectionView;
- (void)requestInfo;
- (void)updateCollectionView;
- (void)defaultBackButtonItem;

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated;

- (void)backForResult:(id)info resultCode:(NSInteger)resultCode;

- (void)showNullView:(UIView*)parentV title:(NSString*)title icon:(NSString*)icon;
- (void)removeNullView;
- (void)showNetErrorV:(UIView*)parentV reloadBlock:(void(^)())reloadBlock ;
- (void)removeNetErrorV;

@end
