//
//  SQBaseCollectionViewController.m
//  youthGo
//
//  Created by qbshen on 16/6/14.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import "SQBaseCollectionViewController.h"


@interface SQBaseCollectionViewController ()

@property (nonatomic) UIView* mNullView;
@property (nonatomic) UIView* mErrorView;

@end


@implementation SQBaseCollectionViewController

+ (instancetype)createViewController:(id)createArgs
{
    SQBaseCollectionViewController * vc = [[SQBaseCollectionViewController alloc] initWithCollectionViewLayout:[UICollectionViewFlowLayout new]];
    vc.createArgs = createArgs;
    
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultBackButtonItem];
    [self initTitleBar];
    [self initCollectionView];
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

- (void)requestInfo
{
    if (!self.originDic) {
        self.originDic = [NSMutableDictionary dictionary];
    }
}

- (void)pushViewController:(UIViewController *)vc animated:(BOOL)animated {
    
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)initTitleBar
{
    //    self.navigationItem.leftBarButtonItem = [self leftBarButtonItem];
    //    if(nil == self.navigationItem.leftBarButtonItem){
    //        [self defaultBackButtonItem];
    //    }
    
    [self defaultBackButtonItem];
    
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
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
//    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if ([self.backDelegate respondsToSelector:@selector(backForResult:resultCode:)]) {
        NSLog(@"%@", self.backArgs);
        [self.backDelegate backForResult:self.backArgs resultCode:self.backCode];
    }
}

- (void)backForResult:(id)info resultCode:(NSInteger)resultCode
{
    
}


//- (void)showNullView:(UIView *)parentV title:(NSString *)title icon:(NSString *)icon
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
