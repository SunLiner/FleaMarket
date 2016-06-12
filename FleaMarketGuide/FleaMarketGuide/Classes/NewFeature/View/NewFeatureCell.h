//
//  NewFeatureCell.h
//  FleaMarketGuide
//
//  Created by ALin on 16/6/12.
//  Copyright © 2016年 ALin. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PlayFinishedNotify @"PlayFinishedNotify"

@interface NewFeatureCell : UICollectionViewCell
/** startImage */
@property (nonatomic, strong)  UIImage * _Nonnull startImage;

/** 视频路径 */
@property (nonatomic, strong) NSString * _Nonnull moviePath;
@end
