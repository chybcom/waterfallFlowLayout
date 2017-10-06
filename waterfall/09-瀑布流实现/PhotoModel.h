//
//  PhotoModel.h
//  09-瀑布流实现
//
//  Created by apple on 17/7/22.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoModel : NSObject

/** 图片宽 */
@property (nonatomic, assign) NSInteger w;

/** 图片的高 */
@property (nonatomic, assign) NSInteger h;

/** 图片url */
@property (nonatomic, copy) NSString *img;

/** 价格 */
@property (nonatomic, copy) NSString *price;



@end




/*
 <key>h</key>
 <integer>275</integer>
 <key>img</key>
 <string>http://s13.mogujie.cn/b7/bao/131012/vud8_kqywordekfbgo2dwgfjeg5sckzsew_310x426.jpg_200x999.jpg</string>
 <key>price</key>
 <string>¥169</string>
 <key>w</key>
 <integer>200</integer>
 
 */
