//
//  ALinFlowLayout.m
//  FleaMarketGuide
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import "ALinFlowLayout.h"

@implementation ALinFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.itemSize = self.collectionView.bounds.size;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
}
@end
