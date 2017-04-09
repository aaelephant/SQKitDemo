//
//  SNBaseViewController.m
//  soccernotes
//
//  Created by sqb on 15/6/25.
//  Copyright (c) 2015年 sqp. All rights reserved.
//

#import "SQBasePageViewController.h"

@interface SQBasePageViewController ()<UIAlertViewDelegate,BaseBackForResultDelegate,UIActionSheetDelegate>

@property UINavigationController *nav;
//@property (copy) void(^loginCompleteBlock)(RequestResult*,id);

@end


@implementation SQBasePageViewController

+ (instancetype)createViewController:(id)createArgs
{
    NSAssert(NO, @"this function must be implemented");
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultBackButtonItem];
    [self initTitleBar];
    [self initTableView];    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter]removeObserver:self];
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

- (void)requestInfo
{
    if (!self.originDic) {
        self.originDic = [[NSMutableDictionary alloc]init];
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

- (void)initTitleBarColor{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor blackColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20.0], NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
}

- (UIBarButtonItem *)leftBarButtonItem{
    return nil;
}
- (void)defaultBackButtonItem{
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                      style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = barButtonItem;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
//    self.navigationController.navigationBar.barTintColor=[UIColor whiteColor];

}



- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.backDelegate respondsToSelector:@selector(backForResult:resultCode:)]) {
        NSLog(@"%@",self.backArgs);
        [self.backDelegate backForResult:self.backArgs resultCode:self.backCode];
    }
}

- (void)backForResult:(id)info resultCode:(NSInteger)resultCode
{
    NSLog(@"Base backForResult");
}

//- (void)hideNAVAndStatusBar:(BOOL)hiden
//{
//    self.navigationController.navigationBarHidden=hiden;
//    [[UIApplication sharedApplication] setStatusBarHidden:hiden withAnimation:UIStatusBarAnimationFade];
//    不但要在Info.plist中增加 Status bar is initially hidden一行,选择为 YES,
    
//    还需增加 View controller-based status bar appearance 一行,选择为 NO。
//}
#pragma mark share
- (void)shareBtnItem
{
    UIImage *img = [UIImage imageNamed:@"share_icon"];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithImage:img style:UIBarButtonItemStylePlain target:self action:@selector(clickOnShareBtn)];
    self.navigationItem.rightBarButtonItem = shareItem;
}

- (void)clickOnShareBtn
{
//    if (self.tabBarController.selectedIndex == 0) {
//         [[PVShareSdkHelper sharedMMShareSDKHelper] shareForPlat:@"http://baidu.com"];
//    }else {
//        PVShareViewController *vc = [PVShareViewController  createViewController:nil];
//        [self.navigationController pushViewController:vc animated:NO];
//    }

}

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
