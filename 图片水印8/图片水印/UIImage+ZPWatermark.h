//
//  UIImage+ZPWatermark.h
//  图片水印
//
//  Created by 赵鹏 on 2018/12/30.
//  Copyright © 2018 apple. All rights reserved.
//

/**
 用于给图片加水印的UIImage类的分类。
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ZPWatermark)

+ (instancetype)watermarkWithBackgroundImage:(NSString *)bgImageName watermarkImage:(NSString *)watermarkImageName watermarkWord:(NSString *)watermarkWord;

@end

NS_ASSUME_NONNULL_END
