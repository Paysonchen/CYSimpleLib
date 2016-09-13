//
//  UtilsHelper.h
//  HealthHome
//
//  Created by Chen on 14-4-2.
//  Copyright (c) 2014年 easepal. All rights reserved.
//


@interface UtilsHelper : NSObject

/**
 *  取消tableview多余的空cell
 *
 *  @param tableView 要设置的tableView
 */
+ (void)setExtraCellLineHidden: (UITableView *)tableView;

/**
 *  取消tableview 分隔线 左边的距离
 *
 *  @param tableView 要设置的tableView
 */
+(void) cancelLeftLinePadding:(UITableView *)tableView;


#pragma mark- 路径
///**
// *  数据缓存路径
// *
//
// *  @param fname 文件名
// *
// *  @return 
// */
//+(NSString*) currentFilePathWithFileName:(NSString*)fname;

/**
 *  获取沙盒路径(获取图片路径)
 *
 *  @param fname      文件名
 *  @param folderName 文件夹名
 *
 *  @return 文件路径  ……\1\A.PNG
 */
+(NSString*) filePathWithFileName:(NSString*)fname folderName:(NSString*) folderName;

/**
 *  获取沙盒路径
 *
 *  @param fname 文件名
 *
 *  @return 文件路径  ……\A.PNG
 */
+(NSString*) filePathWithFileName:(NSString*)fname;

#pragma mark- 存储图片
/**
 *  存储图像
 *
 *  @param image      图片文件
 *  @param fileName   文件名
 *  @param folderName 文件夹名
 *
 *  @return 存储路径
 */
+(NSString *) saveImage:(UIImage *) image fileName:(NSString *) fileName folderName:(NSString *) folderName;

/**
 *  验证 格式是否是email
 *
 *  @param email email地址
 *
 *  @return 是否格式正确
 */
+ (BOOL)validateEmail:(NSString *)email;

/**
 *  判断字符串是否为空
        nil
        [NSNull null]
        @""
        @"nil"  
        @"<null>"
        ……
 *
 *  @param text 字符串
 *
 *  @return 是否为空
 */
+ (BOOL)stringIsEmpty:(NSString *) text;


/**
 *  MD5加密
 *
 *  @param str 明文
 *
 *  @return 密文
 */
+ (NSString *)md5Digest:(NSString *)str;


/**
 *  通过颜色绘制图片
 *
 *  @param color 所需要的纯色
 *
 *  @return 纯色图像
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;



#pragma mark- 对视图的操作
/**
 *  对视图加边线
    - 描边颜色默认 RGB(0xbc, 0xbc, 0xbc)
 *
 *  @param view 需要描边的视图
 */
+(void) addLayerLineToView:(UIView *) view;

/**
 *  对视图加边线
    - 且需要指定描边的宽度
    - 描边颜色默认 RGB(0xbc, 0xbc, 0xbc)
 *
 *  @param view  需要描边的视图
 *  @param w     需要描边的视图的宽度
 */
+(void) addLayerLineToView:(UIView *) view width:(CGFloat) w;

/**
 *  对视图加边线
    -且需要指定描边的宽度
 *
 *  @param view  需要描边的视图
 *  @param w     需要描边的视图的宽度
 *  @param color 需要描边的视图的边线的颜色
 */
+(void) addLayerLineToView:(UIView *) view width:(CGFloat) w color:(UIColor *) color;


/**
 *  自适应拉伸Button 背景图片
 *
 *  @param button
 */
+(void) stretchableImageToBackgroundWithButton:(UIButton *) button;

/**
 *  获取视图快照
 *
 *  @param view 要截取快照的视图
 *  @param size 截取尺寸
 *
 *  @return 截取后的图片
 */
+(UIImage *) getScreenShot:(UIView *) view size:(CGSize) size;
+(UIImage *) getScreenShot:(UIView *) view size:(CGSize) size imageSize:(CGSize) imageSize;


#pragma mark- 字符串操作
/**
 *  判断是否是正确的手机号码
 *
 *  @param phone 手机号码
 *
 *  @return 是否正确
 */
+(BOOL) phoneNumValide:(NSString *) phone;



#pragma mark- viewControllers处理

/**
 *  获取基础vc
 *
 *  @return 基础vc
 */
+ (UIViewController *)appRootViewController;

/**
 *  获取当前展示的vc
 *
 *  @return 当前展示的vc
 */
+ (UIViewController *)currentViewController;

/**
 *  在非ViewController 类中需要push时调用,该方法调用 currentViewController
 *
 *  @param viewController 需要push的viewController
 */
+(void) pushViewController:(UIViewController *) viewController;

#pragma mark- 对图片处理
/**
 *  将图片设置成指定的透明度
 *
 *  @param alpha 透明度
 *  @param image 原始图片
 *
 *  @return 透明化处理后的图片
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;

#pragma mark- 对按钮的处理
/**
 *  对带文字和图片的按钮进行格式化，图片在上 文字在下，居中
 *
 *  @param button 需要格式化的按钮
 */
+(void) button2Format:(UIButton *) button;

#pragma mark- 日期操作
/**
 *  通过日期得到星期几
 *
 *  @param date 日期
 *
 *  @return 星期
 */
+(NSString *) getWeekDayFromDate:(NSDate *) date;

#pragma mark- 版本号处理
/**
 *  版本名
 *
 *  @return 返回Version 1.0
 */
+(NSString *) versionName;

@end
