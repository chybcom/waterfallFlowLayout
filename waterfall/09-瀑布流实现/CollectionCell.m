//
//  CollectionCell.m
//  09-瀑布流实现
//
//  Created by apple on 17/7/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "CollectionCell.h"
#import "UIImageView+WebCache.h"
#import "PhotoModel.h"


@interface CollectionCell ()

/** 图片 */
@property (nonatomic, weak) UIImageView *imageView;

/** 文字 */
@property (nonatomic, weak) UILabel *label;


@end


@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSLog(@"%s",__func__);
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [self.contentView addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:15];
        [label sizeToFit];
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    return self;
}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    NSLog(@"%s",__func__);

    self.imageView.frame = self.bounds;
    
    CGRect frame = self.label.frame;
    frame.origin.y = self.frame.size.height * 0.75;
    self.label.frame = frame;
    
    CGPoint point = self.label.center;
    point.x = self.frame.size.width * 0.5;
    self.label.center = point;
    
    [self.label sizeToFit];
    
}


+ (instancetype)cellWithCollectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"%s",__func__);

    CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];

    return cell;
}

- (void)setPhotoModel:(PhotoModel *)photoModel{

    _photoModel = photoModel;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:photoModel.img] placeholderImage:nil];
    
    self.label.text = photoModel.price;
}




@end
