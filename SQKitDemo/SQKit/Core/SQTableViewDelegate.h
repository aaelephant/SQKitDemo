//
//  SQTableViewDelegate.h
//  SQTableViewKit
//
//  Created by qbshen on 16/6/15.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, SQTableViewSectionStyle){
    SQTableViewSectionStyleFir = 0,
    SQTableViewSectionStyleSec,
    SQTableViewSectionStyleThi,
    SQTableViewSectionStyleFou,
};

@interface SQBaseTableViewInfo : NSObject

@property (nonatomic, strong) NSString * cellNibName;
@property (nonatomic, strong) NSString * cellClassName;
@property (nonatomic, assign) UITableViewCellStyle cellStyle;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) void(^gotoNextBlock)(id);
@property (nonatomic, copy) void(^deselectBlock)(id);
@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign) CGFloat cellHeight;

@property id args;

@end


@interface SQTableViewHeadViewInfo : SQBaseTableViewInfo

@end


@interface SQTableViewFootViewInfo : SQBaseTableViewInfo

@end

@interface SQTableViewSectionInfo : NSObject

@property (nonatomic, strong, readonly) SQTableViewHeadViewInfo * headViewInfo;
@property (nonatomic, strong, readonly) SQTableViewFootViewInfo * footViewInfo;
@property (nonatomic, strong) NSArray * cellDataArray;
@property (nonatomic) BOOL isOpen;

@property (nonatomic, weak) UIViewController * viewController;


-(void)dispatch:(id)args;

@end


#define CELL_HIEGHT_DEFAULT (44.0)
#define CELL_HIEGHT_ZERO (0.0)

@interface SQTableViewCellInfo : SQBaseTableViewInfo

@property (nonatomic, copy) BOOL(^willDeleteBlock)(id);

@end


@interface SQBaseTableViewCell : UITableViewCell

- (void)fillData:(SQBaseTableViewInfo*)info;
- (void)updateTableView:(SQBaseTableViewInfo*)info animal:(UITableViewRowAnimation)animal;

-(void)didHighlight;

-(void)didUnhighlight;
@end

@interface SQBaseTableViewSectionView : UIView

- (void)fillData:(SQBaseTableViewInfo*)info;
- (void)updateTableView:(SQBaseTableViewInfo*)info animal:(UITableViewRowAnimation)animal;

-(void)didHighlight;

-(void)didUnhighlight;
@end


@interface SQTableViewDelegate : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) void(^didScrollBlock)();
@property (nonatomic, copy) void(^didEndScrollBlock)();
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) UITableViewCellEditingStyle editStyle;
@property (nonatomic, strong) NSArray * sectionTitles;

- (void)loadData:(NSDictionary *(^)()) loadDataBlock;

@end
