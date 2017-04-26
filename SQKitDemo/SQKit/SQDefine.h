//
//  SQDefine.h
//  WhaleyVR
//
//  Created by qbshen on 2016/11/2.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#ifndef SQDefine_h
#define SQDefine_h

#import "SNUtilToolHead.h"
#import "WVRRouterDispatcher.h"

#define SQToast(TEXT) ([SQToastTool showMessageCenter:self.view.window withMessage:TEXT? TEXT:@""])
#define SQToastIn(TEXT,VIEW) ([SQToastTool showMessageCenter:VIEW.window withMessage:TEXT? TEXT:@""])
#define SQUP_Window ([[[UIApplication sharedApplication] windows] lastObject])
#define SQToastInKeyWindow(TEXT) ([SQToastTool showMessageCenter:SQUP_Window withMessage:TEXT? TEXT:@""])

#define SQShowProgress ([self showProgress]);

#define SQShowProgressIn(P) ([P showProgress]);
#define SQHideProgressIn(P) ([P hideProgress]);

#define SQHideProgress ([self hideProgress]);
#define SQSizeMake(W,H) (CGSizeMake(fitToWidth(W), fitToWidth(H)));

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:1.0]

#define UIColorFromRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue&0xFF0000)>>16))/255.0 green:((float)((rgbValue&0xFF00)>>8))/255.0 blue:((float)(rgbValue&0xFF))/255.0 alpha:a]

#define DEFAULT_IMAGE_STR (@"default_image")
//#define HOLDER_IMAGE ([UIImage imageNamed:DEFAULT_IMAGE_STR])

#define DEFAULT_HEAD_IMAGE_STR (@"avatar_login")
#define HOLDER_HEAD_IMAGE ([UIImage imageNamed:DEFAULT_HEAD_IMAGE_STR])

#define SQLibraryCache ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject])

#define SQVideoCachFloder (@"/videoCach/")

#define SQCocoaHttpServerRoot ([SQLibraryCache stringByAppendingString:SQVideoCachFloder])

#define SQStrWithNSInteger(NUM) ([NSString stringWithFormat:@"%ld",(NUM)])

#define SQAVAssetExportSessionPATH ([SQLibraryCache stringByAppendingString:@"/AVAssetExportCach/"])

#define NORMAL_SCREEN_WIDTH (375.f)

#define fitToWidth(VALUE) (VALUE*(CGRectGetWidth([[UIScreen mainScreen] bounds]) / NORMAL_SCREEN_WIDTH))

#define section(_sectionID_, _className_) \
compatibility_alias _WVRRouterDispatcher WVRRouterDispatcher; \
+(void)load { \
    [WVRRouterDispatcher registerSection:_sectionID_ className:_className_]; \
}

#define viewController(_pageID_, _className_) \
compatibility_alias _WVRRouterDispatcher WVRRouterDispatcher; \
+(void)load { \
[WVRRouterDispatcher registerViewController:_pageID_ className:_className_]; \
}


#define kWeakSelf(type)  __weak typeof(type) weak##type = type;

#endif /* SQDefine_h */

/**********************  调试输出  **********************/

#ifdef __OPTIMIZE__

#define NSLog(...)              // release时，如果是测试环境就打印到文件，否则不打印 kAppEnvironmentTest
#define DebugLog(...)

#else                           // debug时打印

#define NSLog(...)      printf("%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
#define DebugLog(...)   printf("%s Line %d %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])                // 打印详情

#endif
