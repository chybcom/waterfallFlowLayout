//
//  ViewLayout.h
//  09-瀑布流实现
//
//  Created by apple on 17/7/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewLayout;

@protocol ViewLayoutDelegate <NSObject>

// 必须要实现的方法
@required
/** 返回 index 位置的item的高 */
- (CGFloat)viewLayout:(ViewLayout *)ViewLayout heightForItemAtIndex:(NSInteger)index width:(CGFloat)width;


// 可选实现的方法
@optional
/** 返回 ViewLayout 布局的最大例数 */
- (CGFloat)numberOfMaxColumnInViewLayout:(ViewLayout *)viewLayout;

/** 返回 ViewLayout 布局每列的间距 */
- (CGFloat)numberOfColumnMarginInViewLayout:(ViewLayout *)viewLayout;

/** 返回 ViewLayout 布局的行间距 */
- (CGFloat)numberOfRowMarginInViewLayout:(ViewLayout *)viewLayout;

/** 返回 ViewLayout 布局的上左下右边框间距 */
- (UIEdgeInsets)edgeInsetsOfEdgeInViewLayout:(ViewLayout *)viewLayout;

@end


@interface ViewLayout : UICollectionViewLayout


/** ViewLayout 代理属性 */
@property (nonatomic, weak) id <ViewLayoutDelegate> delegate;


@end

