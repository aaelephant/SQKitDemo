//
//  SQCollectionViewDelegate.m
//  SQCollectionDemo
//
//  Created by qbshen on 16/6/14.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import "SQCollectionViewDelegate.h"


@interface SQCollectionViewDelegate ()

@property (nonatomic) NSMutableDictionary *mOriginDic;
@property (atomic, assign) BOOL isExecBlock;

@end


@implementation SQCollectionViewDelegate

#pragma mark - loadDataBlock

- (void)loadData:(NSDictionary *(^)()) loadDataBlock
{
    self.mOriginDic = [loadDataBlock() mutableCopy];
}

//- (NSString*)kSection:(NSInteger)section
//{
//    return [NSString stringWithFormat:@"%ld",(long)section];
//}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.mOriginDic.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    sectionInfo.sectionIndex = section;
    return sectionInfo.cellDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(indexPath.section)];
    SQBaseCollectionViewInfo * cellInfo = sectionInfo.cellDataArray[indexPath.row];
    SQBaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellInfo.cellNibName? cellInfo.cellNibName:cellInfo.cellClassName forIndexPath:indexPath];
    cellInfo.cellIndex = indexPath.row;
//    if (cellInfo.viewTag!=cell||cellInfo.needRefresh) {
        cellInfo.viewTag = cell;
        [cell fillData:cellInfo];
//    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(indexPath.section)];
    SQBaseCollectionViewInfo * cellInfo = sectionInfo.cellDataArray[indexPath.row];
    if (cellInfo.gotoNextBlock) {
        cellInfo.gotoNextBlock(cellInfo);
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(indexPath.section)];
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SQCollectionViewHeaderInfo * headerInfo = sectionInfo.headerInfo;
        SQBaseCollectionReusableHeader *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerInfo.cellNibName? headerInfo.cellNibName:headerInfo.cellClassName forIndexPath:indexPath];
//        if (headerInfo.viewTag!=headerView||headerInfo.needRefresh) {
            [headerView fillData:headerInfo];
//        }
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        SQCollectionViewFooterInfo * footerInfo = sectionInfo.footerInfo;
        SQBaseCollectionReusableFooter *footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerInfo.cellNibName? footerInfo.cellNibName:footerInfo.cellClassName forIndexPath:indexPath];
//        if (footerInfo.viewTag!=footerview||footerInfo.needRefresh) {
            [footerview fillData:footerInfo];
//        }
        reusableview = footerview;
    }
    return reusableview;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(indexPath.section)];
    SQBaseCollectionViewInfo * cellInfo = sectionInfo.cellDataArray[indexPath.row];
    return cellInfo.cellSize;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    SQCollectionViewHeaderInfo * headerInfo = sectionInfo.headerInfo;
    NSLog(@"header size: height:%f",headerInfo.cellSize.height);
    return headerInfo.cellSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    SQCollectionViewFooterInfo * footerInfo = sectionInfo.footerInfo;
    
    return footerInfo.cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    return sectionInfo.minLineSpace;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    return sectionInfo.minItemSpace;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    SQCollectionViewSectionInfo * sectionInfo = self.mOriginDic[@(section)];
    return sectionInfo.edgeInsets;
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
//- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
//{
//    CGFloat width = fitToWidth(305.f);
//    CGFloat contentXoffset = targetContentOffset->x;
////    CGFloat distanceFromBottomX = contentXoffset + width - scrollView.contentSize.width;
//    int index = fabs(contentXoffset /width);
//    NSLog(@"targetContentOffsetX%f index%d",contentXoffset,index);
//    [(UICollectionView*)scrollView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (self.DidEndDecelerating) {
        self.DidEndDecelerating(scrollView);
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    CGFloat width = scrollView.frame.size.width;
    CGFloat contentXoffset = scrollView.contentOffset.x;
    CGFloat distanceFromBottomX = contentXoffset + width - scrollView.contentSize.width;
    
    if (distanceFromBottomX < 0) {
        
        _isExecBlock = YES;
    } else {
        _isExecBlock = NO;
    }
    if (self.WillBeginDragging) {
        self.WillBeginDragging(scrollView);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat width = scrollView.frame.size.width;
    CGFloat contentXoffset = scrollView.contentOffset.x;
    CGFloat distanceFromBottomX = contentXoffset + width - scrollView.contentSize.width;
    
//    NSLog(@"contentXoffset:%d  distance:%d", (int)contentXoffset, (int)distanceFromBottomX);
    
    if (distanceFromBottomX >= 0) {
        
        if (self.scrollBottomBlock && !_isExecBlock) {
            _isExecBlock = YES;
            self.scrollBottomBlock(YES);
        }
    }
    
    CGFloat contentYoffset = scrollView.contentOffset.y;
//    if (contentYoffset<=kNavBarHeight) {
        if (self.scrollDidScrolling) {
            self.scrollDidScrolling(contentYoffset);
        }
//    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
//    CGFloat width = scrollView.frame.size.width;
//    CGFloat contentXoffset = scrollView.contentOffset.x;
//    CGFloat distanceFromBottomX = contentXoffset + width - scrollView.contentSize.width;

    if (self.scrollDidToTop) {
        self.scrollDidToTop(YES);
    }
}

//当cell高亮时返回是否高亮
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)colView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQBaseCollectionViewCell* cell = (SQBaseCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
    //设置(Highlight)高亮下的颜色
    [cell didHighlight];
}

- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    SQBaseCollectionViewCell* cell = (SQBaseCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
    //设置(Nomal)正常状态下的颜色
    [cell didUnhighlight];
}

- (void)dealloc
{
    DebugLog(@"");
}

@end


@implementation SQBaseCollectionViewInfo

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQCollectionViewHeaderInfo

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQCollectionViewFooterInfo

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQCollectionViewSectionInfo

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQCollectionViewCellInfo

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQBaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray * cons = self.constraints;
    for (NSLayoutConstraint* constraint in cons) {
//        NSLog(@"%ld",(long)constraint.firstAttribute);
        //据底部0
        constraint.constant = fitToWidth(constraint.constant);
    }
    NSArray* subviews = self.subviews;
    for (UIView * view in subviews) {
        NSArray * cons = view.constraints;
        for (NSLayoutConstraint* constraint in cons) {
//            NSLog(@"%ld",(long)constraint.firstAttribute);
            //据底部0
            constraint.constant = fitToWidth(constraint.constant);
        }
    }
}

- (void)fillData:(SQBaseCollectionViewInfo*)info
{
    NSAssert(YES, @"must ovrried in sub class");
}

- (void)didHighlight
{

}

- (void)didUnhighlight
{

}

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQBaseCollectionReusableHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray * cons = self.constraints;
    for (NSLayoutConstraint* constraint in cons) {
//        NSLog(@"%ld",(long)constraint.firstAttribute);
        //据底部0
        constraint.constant = fitToWidth(constraint.constant);
    }
    
    for (UIView * view in self.subviews) {
        NSArray * cons = view.constraints;
        for (NSLayoutConstraint* constraint in cons) {
//            NSLog(@"%ld",(long)constraint.firstAttribute);
            //据底部0
            constraint.constant = fitToWidth(constraint.constant);
        }
    }
}

- (void)fillData:(SQBaseCollectionViewInfo *)info
{
    NSAssert(YES, @"must ovrried in sub class");
}

- (void)dealloc {
    DebugLog(@"");
}

@end


@implementation SQBaseCollectionReusableFooter

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSArray * cons = self.constraints;
    for (NSLayoutConstraint* constraint in cons) {
        //        NSLog(@"%ld",(long)constraint.firstAttribute);
        //据底部0
        constraint.constant = fitToWidth(constraint.constant);
    }
    
    for (UIView * view in self.subviews) {
        NSArray * cons = view.constraints;
        for (NSLayoutConstraint* constraint in cons) {
            //            NSLog(@"%ld",(long)constraint.firstAttribute);
            //据底部0
            constraint.constant = fitToWidth(constraint.constant);
        }
    }
}

- (void)fillData:(SQBaseCollectionViewInfo *)info
{
    NSAssert(YES, @"must ovrried in sub class");
}

- (void)dealloc {
    DebugLog(@"");
}

@end
