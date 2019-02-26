//
//  DYZFlowLayout.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/2/12.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZFlowLayout.h"

static NSInteger iItemMargin = 10;
@implementation DYZFlowLayout



- (void)prepareLayout
{
    [super prepareLayout];
    self.sectionInset = UIEdgeInsetsMake(10, 10, 0, 10);
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arrAtt = [super layoutAttributesForElementsInRect:rect];
    
    for (UICollectionViewLayoutAttributes *attributes in arrAtt) {
        if (attributes.representedElementKind == nil) {
            NSIndexPath *indexPath = attributes.indexPath;
            attributes.frame = [self layoutAttributesForItemAtIndexPath:indexPath].frame;
        }
    }
    return arrAtt;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *currentAttributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    UIEdgeInsets sectionInsets = [(UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout sectionInset];
    
    if (indexPath.item == 0) {
        CGRect frame = currentAttributes.frame;
        frame.origin.x = sectionInsets.left;
        currentAttributes.frame = frame;
        return currentAttributes;
    }
    
    NSIndexPath *beforeIndexPath = [NSIndexPath indexPathForItem:indexPath.item - 1 inSection:indexPath.section];
    CGRect beforeFrame = [self layoutAttributesForItemAtIndexPath:beforeIndexPath].frame;
    CGFloat beforeFrameRightPoint = beforeFrame.origin.x + beforeFrame.size.width + iItemMargin;
    CGRect currentFrame = currentAttributes.frame;
    CGRect nextCurrentFrame = CGRectMake(0, currentFrame.origin.y, self.collectionView.frame.size.width, currentFrame.size.height);
    
    if (!CGRectIntersectsRect(beforeFrame, nextCurrentFrame))
    {
        CGRect frame = currentAttributes.frame;
        frame.origin.x = sectionInsets.left;
        currentAttributes.frame = frame;
        return currentAttributes;
    }
    
    CGRect frame = currentAttributes.frame;
    frame.origin.x = beforeFrameRightPoint;
    currentAttributes.frame = frame;
    return currentAttributes;
    
}
@end
