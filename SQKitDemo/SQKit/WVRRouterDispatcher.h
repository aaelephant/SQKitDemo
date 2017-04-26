//
//  WVRRouterDispatcher.h
//  WhaleyVR
//
//  Created by qbshen on 2017/4/8.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WVRRouterDispatcher : NSObject
+ (void)registerSection:(NSString *)sectionID className:(NSString*)className;

+ (id)dispatchSection:(NSString *)sectionID args:(id)args;

+ (void)registerPage:(NSString *)pageID className:(NSString*)className;

+ (id)dispatchPage:(NSString *)pageID args:(id)args attchView:(id)attchView;

+ (void)registerViewController:(NSString *)viewControllerID className:(NSString*)className;

+ (UIViewController *)dispatchController:(NSString *)viewControllerID args:(id)args;
@end
