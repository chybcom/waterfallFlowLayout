//
//  CollectionCell.h
//  09-瀑布流实现
//
//  Created by apple on 17/7/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const cellId = @"cellId";

@class PhotoModel;

@interface CollectionCell : UICollectionViewCell


/** 数据模型 */
@property (nonatomic, strong) PhotoModel *photoModel;

/** 创建 cell */
+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath;


@end
