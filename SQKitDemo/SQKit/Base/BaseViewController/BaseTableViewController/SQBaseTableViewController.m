//
//  SNBaseTableViewController.m
//  soccernotes
//
//  Created by sqb on 15/6/26.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SQBaseTableViewController.h"

@interface SQBaseTableViewController ()<UIActionSheetDelegate>

//@property (copy) void(^loginCompleteBlock)(RequestResult*, id);
@property (nonatomic) UIView* mNullView;
@property (nonatomic) UIView* mErrorView;

@end


@implementation SQBaseTableViewController

+ (instancetype)createViewController:(id)createArgs
{
    SQBaseTableViewController * vc = [SQBaseTableViewController new];
    vc.createArgs = createArgs;
    return vc;
//    NSAssert(NO, @"this function must be implemented");
//    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self defaultBackButtonItem];
    [self initTitleBar];
    [self initTableView];
}

- (void)initTableView
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.sectionFooterHeight = 5;
    self.tableView.sectionHeaderHeight = 5;
    if (!self.tableDelegate) {
        self.tableDelegate = [[SQTableViewDelegate alloc]init];
        self.tableView.dataSource = self.tableDelegate;
        self.tableView.delegate = self.tableDelegate;
        self.keyTool = [SQKeyboardTool new];
        [self.keyTool addKeyHandleWithOwner:self.tableView];
        [self.tableView setTableFooterView:[UIView new]];
    }
}

- (void)updateTableView
{
    [self.tableDelegate loadData:^NSDictionary *{
        return self.originDic;
    }];
    [self.tableView reloadData];
}

- (void)requestInfo
{
    if (!self.originDic) {
        self.originDic = [[NSMutableDictionary alloc]init];
    }
}

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated{
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)initTitleBar
{
    [self defaultBackButtonItem];
}

- (void)initTitleBarColor{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (UIBarButtonItem *)leftBarButtonItem{
    return nil;
}

- (void)defaultBackButtonItem{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
//    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];

}


- (void)backForResult:(id)info resultCode:(NSInteger)resultCode
{
    
}

#pragma mark share
- (void)shareBtnItem
{
    UIImage *img = [UIImage imageNamed:@"share_icon"];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(clickOnShareBtn)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)clickOnShareBtn
{
    
}

//- (void)showNullView:(UIView*)parentV title:(NSString*)title icon:(NSString*)icon
//{
//    SQHideProgress;
//    [self.mErrorView removeFromSuperview];
//    if (!self.mNullView) {
//        self.mNullView = [[WVRLiveNullCell alloc] initWithFrame:CGRectMake(0, 0, parentV.width, parentV.height)];
//        [self.mNullView resetImageToCenter];
//        [self.mNullView setTint:title];
//        [self.mNullView setImageIcon:icon];
//    }
//    [parentV addSubview:self.mNullView];
//}
//
//- (void)removeNullView
//{
//    SQHideProgress;
//    [self.mNullView removeFromSuperview];
//    [self.mErrorView removeFromSuperview];
//}
//
//- (void)showNetErrorV:(UIView*)parentV reloadBlock:(void(^)())reloadBlock
//{
//    SQHideProgress;
//    [self.mNullView removeFromSuperview];
//    if (!self.mErrorView) {
//        self.mErrorView = [WVRNetErrorView errorViewForViewReCallBlock:^{
//            reloadBlock();
//        } withParentFrame:parentV.frame];
//    }
//    [parentV addSubview:self.mErrorView];
//}
//
//- (void)removeNetErrorV
//{
//    SQHideProgress;
//    [self.mErrorView removeFromSuperview];
//    [self.mNullView removeFromSuperview];
//}

#pragma mark - orientation

- (BOOL)shouldAutorotate {
    return NO;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_9_0
- (NSUInteger)supportedInterfaceOrientations
#else
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
#endif
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
