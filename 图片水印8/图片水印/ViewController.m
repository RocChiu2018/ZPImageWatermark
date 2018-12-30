//
//  ViewController.m
//  图片水印
//
//  Created by apple on 16/7/20.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+ZPWatermark.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
/**
 之前利用Quartz2D二维绘图引擎画图的时候都是在View上面进行绘制。因为绘图的时候必须要用到图形上下文而且只有在"drawRect:"方法中系统才能获取到跟当前的View的layer相关联的图形上下文，所以只能在"drawRect:"方法中撰写绘图的代码，在其他方法中则不行。在"drawRect:"方法中调用"UIGraphicsGetCurrentContext()"方法来获取系统已经创建好的跟当前的View的layer相关联的图形上下文，并且该图形上下文的大小为整个手机屏幕的大小；
 想要在图片上添加水印（在图片上绘制图片或文字），就要创建基于位图(bitmap)的图形上下文。与上述的必须在"drawRect:"方法中系统才能获取到跟当前的View的layer相关联的图形上下文不同，创建基于位图的图形上下文不一定非得在"drawRect:"方法或者某些特定的方法中创建。
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self directAddWatermark];
    
//    [self callCategoryMethod];
}

#pragma mark ————— 直接添加水印 —————
- (void)directAddWatermark
{
    UIImage *bgImage = [UIImage imageNamed:@"1"];
    
    /**
     1、创建一个与背景图片大小相同的基于位图(bitmap)的图形上下文：可以把图形上下文看成是一个画板，以后所绘制的内容都画在这个画板上。
     size参数：图形上下文的尺寸；
     opaque参数：不透明度（YES：不透明；NO：透明）；
     scale参数：缩放比例。
     */
    UIGraphicsBeginImageContextWithOptions(bgImage.size, NO, 0.0);
    
    /**
     2、把背景图片绘制在新建的图像上下文中：
     */
    [bgImage drawInRect:CGRectMake(0, 0, bgImage.size.width, bgImage.size.height)];
    
    /**
     3.1 绘制右下角的图片水印：
     */
    UIImage *imageWatermark = [UIImage imageNamed:@"baidu"];
    
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
    NSString *wordWatermark = [NSString stringWithFormat:@"iOS开发者"];
    
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
    
    /**
     6、把加了水印的图片显示到UIImageView控件上面：
     */
    self.imageView.image = newImage;
    
    //把新图片压缩成PNG格式的二进制数据：
    NSData *data = UIImagePNGRepresentation(newImage);
    
    //把新图片的二进制数据写入到APP的沙盒中：
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"new.png"];
    NSLog(@"path = %@", path);
    
    [data writeToFile:path atomically:YES];
}

#pragma mark ————— 调用分类里的方法添加水印 —————
- (void)callCategoryMethod
{
    UIImage *image = [UIImage watermarkWithBackgroundImageName:@"1" watermarkImageName:@"baidu" watermarkWord:@"iOS开发者"];
    
    self.imageView.image = image;
}

@end
