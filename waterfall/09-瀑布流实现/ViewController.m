//
//  ViewController.m
//  09-瀑布流实现
//
//  Created by apple on 17/7/21.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"
#import "ViewLayout.h"

#import "MJRefresh.h"
#import "MJExtension.h"
#import "PhotoModel.h"
#import "CollectionCell.h"


@interface ViewController ()<UICollectionViewDataSource,ViewLayoutDelegate>

/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;


/** 装有所有商品的模型数组 */
@property (nonatomic, strong) NSMutableArray *photos;

@end


//static NSString * const cellId = @"cellId";

@implementation ViewController


- (NSMutableArray *)photos{

    if (!_photos) {
        _photos = [NSMutableArray array];
    }
    return _photos;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupCollectionView];
    
    [self refresh];
}


- (void)setupCollectionView{
    ViewLayout *layout = [[ViewLayout alloc]init];
    layout.delegate = self;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    [self.view addSubview:collectionView];

    //注册cell
    [collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:cellId];
    
    self.collectionView = collectionView;
}

- (void)refresh{
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewPhotos)];
    [self.collectionView.mj_header beginRefreshing];
    
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePhotos)];

}

- (void)loadNewPhotos{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.photos removeAllObjects];
        
        self.photos = [PhotoModel mj_objectArrayWithFilename:@"1.plist"];
        
        [self.collectionView.mj_header endRefreshing];

        //刷新数据
        [self.collectionView reloadData];
        
    });
}

- (void)loadMorePhotos{

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 模拟把数组添加到可变数组中
        [self.photos addObjectsFromArray:[PhotoModel mj_objectArrayWithFilename:@"1.plist"]];
        
        [self.collectionView.mj_footer endRefreshing];
        
        //刷新数据
        [self.collectionView reloadData];
        
    });
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    self.collectionView.mj_footer.hidden = (self.photos.count == 0);

    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionCell *cell = [CollectionCell cellWithCollectionView:collectionView indexPath:indexPath];
    
    cell.photoModel = self.photos[indexPath.item];
    
//    NSLog(@"地址：%p    %zd",cell,indexPath.item);
    
    return cell;
}

#pragma mark - <ViewLayoutDelegate>
- (CGFloat)viewLayout:(ViewLayout *)ViewLayout heightForItemAtIndex:(NSInteger)index width:(CGFloat)width{

    // 取出第 index 位置的模型
    PhotoModel *photo = self.photos[index];
    
    return width * photo.h / photo.w;
}


//- (CGFloat)numberOfRowMarginInViewLayout:(ViewLayout *)viewLayout{
//
//    return 3;
//}
//
//- (CGFloat)numberOfColumnMarginInViewLayout:(ViewLayout *)viewLayout{
//
//    return 3;
//}

//- (CGFloat)numberOfMaxColumnInViewLayout:(ViewLayout *)viewLayout{
//
//    return 4;
//}

//- (UIEdgeInsets)edgeInsetsOfEdgeInViewLayout:(ViewLayout *)viewLayout{
//
//    return UIEdgeInsetsMake(50, 20, 30, 100);
//}

@end
