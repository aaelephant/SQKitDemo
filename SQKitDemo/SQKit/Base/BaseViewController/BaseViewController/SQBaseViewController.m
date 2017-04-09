//
//  SNBaseViewController.m
//  soccernotes
//
//  Created by sqb on 15/6/25.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SQBaseViewController.h"

@interface SQBaseViewController ()<UIAlertViewDelegate,BaseBackForResultDelegate,UIActionSheetDelegate>

@property UINavigationController *nav;
//@property (copy) void(^loginCompleteBlock)(RequestResult*, id);
@property (nonatomic) UIView* mNullView;
@property (nonatomic) UIView* mErrorView;

@end


@implementation SQBaseViewController

//+(instancetype)createViewController:(id)createArgs
//{
//    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"SQLogManagerController" bundle:nil];
//    SQLogManagerController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"SQLogManagerController"];
//    return vc;
//}

+ (instancetype)createViewController:(id)createArgs
{
    NSAssert(NO, @"this function must be implemented");
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initTitleBar];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)initTableView
{
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

- (void)initCollectionView
{
    for (NSString* cur in self.headerNibNames) {
        [self.collectionView registerNib:[UINib nibWithNibName:cur bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cur];
    }
    for (NSString * cur in self.headerClassNames) {
        [self.collectionView registerClass:NSClassFromString(cur) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:cur];
    }
    for (NSString* cur in self.footerNibNames) {
        [self.collectionView registerNib:[UINib nibWithNibName:cur bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cur];
    }
    for (NSString * cur in self.footerClassNames) {
        [self.collectionView registerClass:NSClassFromString(cur) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:cur];
    }
    for (NSString* cur in self.cellNibNames) {
        [self.collectionView registerNib:[UINib nibWithNibName:cur bundle:nil] forCellWithReuseIdentifier:cur];
    }
    for (NSString * cur in self.cellClassNames) {
        [self.collectionView registerClass:NSClassFromString(cur) forCellWithReuseIdentifier:cur];
    }
    
    self.collectionView.backgroundColor = UIColorFromRGB(0xeeeeee);
    if (!self.collectionDelegate) {
        self.collectionDelegate = [[SQCollectionViewDelegate alloc]init];
        self.collectionView.dataSource = self.collectionDelegate;
        self.collectionView.delegate = self.collectionDelegate;
        self.keyTool = [SQKeyboardTool new];
        [self.keyTool addKeyHandleWithOwner:self.collectionView];
    }
}

- (void)updateCollectionView
{
    kWeakSelf(self);
    
    [self.collectionDelegate loadData:^NSDictionary *{
        return weakself.originDic;
    }];
    [self.collectionView reloadData];
}

-(void)requestInfo
{
    if (!self.originDic) {
        self.originDic = [[NSMutableDictionary alloc]init];
    }
    if (!self.collectionVOriginDic) {
        self.collectionVOriginDic = [NSMutableDictionary dictionary];
    }
    if (!self.tableVOriginDic) {
        self.tableVOriginDic = [NSMutableDictionary dictionary];
    }
    [self updateTableView];
}

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated{
    [self.navigationController pushViewController:vc animated:animated];
}


- (void)receiveNtf:(NSNotification*)ntf
{
    void(^block)() = ntf.object;
    block();
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)initTitleBar
{
//    self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
//    if(nil == self.navigationItem.leftBarButtonItem){
        [self defaultBackButtonItem];
//    }
    //    [self initTitleBarColor];
}

- (void)initTitleBarColor {
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (UIBarButtonItem *)leftBarButtonItem {
    return nil;
}

- (void)defaultBackButtonItem {
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                      style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor=[UIColor blackColor];
//    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];

}

- (void)backForResult:(id)info resultCode:(NSInteger)resultCode
{
    NSLog(@"Base backForResult");
}


- (void)phoneButtonItem {
    
}

- (void)shareBtnItem {
    
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
