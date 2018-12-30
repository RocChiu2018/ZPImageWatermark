//
//  UIImage+ZPWatermark.m
//  图片水印
//
//  Created by 赵鹏 on 2018/12/30.
//  Copyright © 2018 apple. All rights reserved.
//

#import "UIImage+ZPWatermark.h"

@implementation UIImage (ZPWatermark)

+ (instancetype)watermarkWithBackgroundImageName:(NSString *)bgImageName watermarkImageName:(NSString *)watermarkImageName watermarkWord:(NSString *)watermarkWord
{
    UIImage *bgImage = [UIImage imageNamed:bgImageName];
    
    /**
     1、创建一个与背景图片大小相同的基于位图(bitmap)的图形上下文：
     */
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    /**
     2、把背景图片绘制在新建的图像上下文中：
     */
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    /**
     3.1 绘制右下角的图片水印：
     */
    UIImage *imageWatermark = [UIImage imageNamed:watermarkImageName];
    
    CGFloat scale = 0.2;  //图片水印的缩放比例
    CGFloat margin = 5;  //图片水印与右侧和底下的间距
    CGFloat imageWatermarkW = imageWatermark.size.width * scale;  //图片水印的宽度
    CGFloat imageWatermarkH = imageWatermark.size.height * scale;  //图片水印的高度
    CGFloat imageWatermarkX = bgImage.size.width - imageWatermarkW - margin;  //图片水印的X坐标
    CGFloat imageWatermarkY = bgImage.size.height - imageWatermarkH - margin;  //图片水印的Y坐标
    
    [imageWatermark drawInRect:CGRectMake(imageWatermarkX, imageWatermarkY, imageWatermarkW, imageWatermarkH)];
    
    /**
     3.2 绘制左下角的文字水印：
     */
    NSString *wordWatermark = watermarkWord;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:[UIColor blueColor] forKey:NSForegroundColorAttributeName];  //设置文字颜色
    [dict setObject:[UIFont systemFontOfSize:30] forKey:NSFontAttributeName];  //设置文字大小
    
    [wordWatermark drawAtPoint:CGPointMake(10, 350) withAttributes:dict];
    
    /**
     4、从图形上下文中取出加完水印的图片：
     */
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    /**
     5、结束图形上下文：
     */
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
