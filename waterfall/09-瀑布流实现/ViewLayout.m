//
//  ViewLayout.m
//  09-瀑布流实现
//
//  Created by apple on 17/7/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewLayout.h"

/** 默认最大例数 */
static const NSInteger defaultMaxColumn = 3;

/** 默认例间距 */
static const CGFloat defaultdefaultColumnMargin = 10;

/** 默认行间距 */
static const CGFloat defaultdefaultRowMargin = 10;

/** 默认边框间距 */
static const UIEdgeInsets defaultEdgeInsets = {10, 10 ,10, 10};


@interface ViewLayout ()


/** 装有所有的布局性的数组 */
@property (nonatomic, strong) NSMutableArray *attributesArray;


/** 装有所有有例的高度 */
@property (nonatomic, strong) NSMutableArray *columnHeights;


//方法声明
- (CGFloat)maxColumn;
- (CGFloat)columnMargin;
- (CGFloat)rowMargin;
- (UIEdgeInsets)edgeInsets;


@end


@implementation ViewLayout

/**  返回最大列数 方法实现*/
- (CGFloat)maxColumn{

    if ([self.delegate respondsToSelector:@selector(numberOfMaxColumnInViewLayout:)]) {
        return [self.delegate numberOfMaxColumnInViewLayout:self];
    }else{
    
        return defaultMaxColumn;
    }
}

/** 返回列间距 方法实现*/
- (CGFloat)columnMargin{
    if ([self.delegate respondsToSelector:@selector(numberOfColumnMarginInViewLayout:)]) {
        return [self.delegate numberOfColumnMarginInViewLayout:self];
    }else{
        
        return defaultdefaultColumnMargin;
    }
}

/** 行间距 方法实现*/
- (CGFloat)rowMargin{
    if ([self.delegate respondsToSelector:@selector(numberOfRowMarginInViewLayout:)]) {
        return [self.delegate numberOfRowMarginInViewLayout:self];
    }else{
        
        return defaultdefaultRowMargin;
    }
}

/** 边框的间距 方法实现*/
- (UIEdgeInsets)edgeInsets{
    if ([self.delegate respondsToSelector:@selector(edgeInsetsOfEdgeInViewLayout:)]) {
        return [self.delegate edgeInsetsOfEdgeInViewLayout:self];
    }else{
        
        return defaultEdgeInsets;
    }
}

- (NSMutableArray *)attributesArray{

    if (!_attributesArray) {
        _attributesArray = [NSMutableArray array];
    }
    return _attributesArray;
}

- (NSMutableArray *)columnHeights{

    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}


// 准备开始布局时调用方法
- (void)prepareLayout{

    [super prepareLayout];
    
//    NSLog(@"%s",__func__);
    
    [self.columnHeights removeAllObjects];
    
    [self.attributesArray removeAllObjects];

    
    
    //先初始给装有所有例高数组赋值
    for (int i = 0; i < self.maxColumn; ++i) {
        self.columnHeights[i] = @(self.edgeInsets.top);
    }

    //获取第总共的cell数量
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    
    //有 for循环为每为个 cell添加布局属性
    
    for (int i = 0; i < count; ++i) {

        //创建第 i 个位置索引
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        
        //根据索引创建布局属性
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        
        [self.attributesArray addObject:attributes];
    }
}


// 返回所有元素的布局属性数组
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{

    return self.attributesArray;
}


// 返回 索引 indexPath 位置的cell的布属性
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    CGFloat width = self.collectionView.bounds.size.width;

    CGFloat w = (width - self.edgeInsets.left - self.edgeInsets.right - ((self.maxColumn - 1) * self.columnMargin)) / self.maxColumn;
    
    
    // 执行代理方法 拿到代理方法返回的高度
    CGFloat h = [self.delegate viewLayout:self heightForItemAtIndex:indexPath.item width:w];
    
    
//    // 找出最短的那一例的高和例号
//    CGFloat miniHeight = MAXFLOAT; //初始默认最小为最大
//    NSInteger miniColumn = 0;      //初始默认最小例号
//    for (int i = 0; i < defaultMaxColumn; ++i) {
//        CGFloat height = [self.columnHeights[i] doubleValue];
//        if (miniHeight > height) {
//            miniHeight = height;
//            miniColumn = i;
//        }
//    }
    
    // 找出最短的那一例的高和例号
    CGFloat miniHeight = [self.columnHeights[0] doubleValue]; //先初始默认数组中第0个元素最小值
    NSInteger miniColumn = 0;      //初始默认最小例号
    for (int i = 1; i < self.maxColumn; ++i) {
        CGFloat height = [self.columnHeights[i] doubleValue];
        if (miniHeight > height) {
            miniHeight = height;
            miniColumn = i;
        }
    }

    CGFloat x = self.edgeInsets.left + miniColumn * (w + self.columnMargin);
    CGFloat y = miniHeight;
    
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    

    attributes.frame = CGRectMake(x, y, w, h);
    
    //保存更新当前高到对应例的数组
    self.columnHeights[miniColumn] = @(CGRectGetMaxY(attributes.frame));

    return attributes;
}

// collectionView的滚动范围
- (CGSize)collectionViewContentSize{

    //找出最高的所在例
    CGFloat maxHeight = 0; //初始最大高为 0
    
    for (int i = 0; i < self.maxColumn; ++i) {
        
        CGFloat height = [self.columnHeights[i] doubleValue];
        
        if (maxHeight < height) {
            maxHeight = height;
        }
    }

    return CGSizeMake(0, maxHeight + self.edgeInsets.bottom);
}

@end
