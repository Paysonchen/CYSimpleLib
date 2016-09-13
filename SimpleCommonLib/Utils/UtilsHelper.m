//
//  UtilsHelper.m
//  HealthHome
//
//  Created by Chen on 14-4-2.
//  Copyright (c) 2014年 easepal. All rights reserved.
//

#import "UtilsHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import "AlertViewUtils.h"
#import "CommonMacro.h"

@implementation UtilsHelper


+ (BOOL)stringIsEmpty:(NSString *) text
{
    if (!text) {
        return YES;
    }
    if ([text isEqual: [NSNull null]])
    {
        return YES;
        
    }
    if ([text isEqualToString:@""]) {
        return YES;
    }
    
    if ([text isEqualToString:@"nil"])
    {
        return YES;
    }
    else if ([text isEqualToString:@"<null>"])
    {
        return YES;
    }
    
    
    if ([text rangeOfString:@"null"].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

+ (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    
    tableView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = nil;
    
}

+(void) cancelLeftLinePadding:(UITableView *)tableView
{
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
}


#pragma mark- 路径





+(NSString*) filePathWithFileName:(NSString*)fname folderName:(NSString*) folderName
{
    NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentFolderPath = [NSString stringWithFormat:@"%@%@",[searchPaths objectAtIndex: 0],folderName];
    
    BOOL isDir = NO;
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL existed = [fileManager fileExistsAtPath:documentFolderPath isDirectory:&isDir];
    if ( !(isDir == YES && existed == YES) )
    {
        [fileManager createDirectoryAtPath:documentFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    
    NSString *filePath = [documentFolderPath stringByAppendingPathComponent:fname];
    NSLog(@"filePath = %@",filePath);
    
    return filePath;
}
+(NSString*) filePathWithFileName:(NSString*)fname
{
    return [self filePathWithFileName:fname folderName:@""];
}

#pragma mark- 存储图片
+(NSString *) saveImage:(UIImage *) image fileName:(NSString *) fileName folderName:(NSString *) folderName
{
    NSString *filePath = [self filePathWithFileName:fileName folderName:folderName];
    NSData *data = UIImageJPEGRepresentation(image, 1);
    [data writeToFile:filePath atomically:YES];
    
    
    return filePath;
}


+ (BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//MD5加密
+ (NSString *)md5Digest:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result );
    return [[NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ] lowercaseString ];
}


#pragma mark- 通过颜色绘制图片
+ (UIImage *)createImageWithColor:(UIColor *)color

{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    
    
    return theImage;
    
}

#pragma mark- 对视图的操作
+(void) addLayerLineToView:(UIView *) view
{
    [self addLayerLineToView:view width:0.5];
    
}
+(void) addLayerLineToView:(UIView *) view width:(CGFloat) w
{
    [self addLayerLineToView:view width:w color:RGB(0xbc, 0xbc, 0xbc)];
    
}
+(void) addLayerLineToView:(UIView *) view width:(CGFloat) w color:(UIColor *) color
{
    view.layer.borderWidth = w;
    view.layer.borderColor = [color CGColor];

    
}



+(void) stretchableImageToBackgroundWithButton:(UIButton *) button
{
    UIImage *image = [button backgroundImageForState:UIControlStateNormal];
    [button setBackgroundImage:[image stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateNormal];
    
    UIImage *highlightedImage = [button backgroundImageForState:UIControlStateHighlighted];
    [button setBackgroundImage:[highlightedImage stretchableImageWithLeftCapWidth:10 topCapHeight:10] forState:UIControlStateHighlighted];

    
}
+(UIImage *) getScreenShot:(UIView *) view size:(CGSize) size
{
    return [self getScreenShot:view size:size imageSize:CGSizeMake(WINDOW_WIDTH *2, WINDOW_HEIGHT *2)];
    
}
+(UIImage *) getScreenShot:(UIView *) view size:(CGSize) size imageSize:(CGSize) imageSize
{
    //    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    
    //CGSizeMake(WINDOW_WIDTH, 65)
    
    
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);     //设置截屏大小
    [[view layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    //    CGRect rect = CGRectMake(166, 211, 426, 320);//这里可以设置想要截图的区域
    CGRect rect = CGRectMake(0, 0, imageSize.width, imageSize.height);//这里可以设置想要截图的区域
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, rect);
    
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    
    return sendImage;
}



#pragma mark- 字符串操作
+(BOOL) phoneNumValide:(NSString *) phone
{
    if ([self stringIsEmpty:phone]) {
        //
        [AlertViewUtils createAlertViewWithMessage:@"手机号不能为空"];
        return NO;
    }
    
    if (![self isValidPhoneNum:phone]) {
        //
        [AlertViewUtils createAlertViewWithMessage:@"手机号格式不正确"];
        
        return NO;
    }
    return YES;
}

//+(BOOL) passwordValide:(NSString *) password
//{
//    
//    if ([self stringIsEmpty:password]) {
//        //
//        [AlertViewUtils createAlertViewWithMessage:@"密码不能为空"];
//        return NO;
//    }
//    
//    if (![self isValidPassword:password]) {
//        //
//        [AlertViewUtils createAlertViewWithMessage:@"密码格式不正确"];
//        
//        return NO;
//    }
//    return YES;
//    
//}

+(BOOL) isValidPhoneNum:(NSString *) number
{
    
    if (!([number length] == 11)) {
        return NO;
    }
    return [self isPureInt:number];
}

+ (BOOL)isPureInt:(NSString*)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}


#pragma mark- viewControllers处理

+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)currentViewController
{
    return [self currentViewController:nil];
    
}
+ (UIViewController *)currentViewController:(UIViewController *) baseVc

{
    UIViewController *nav = [self appRootViewController];
    
    if (baseVc) {
        //
        nav = baseVc;
    }
    if ([nav isKindOfClass:[UINavigationController class]]) {
        //
        
        UINavigationController *nav2 = (UINavigationController *) nav;
        
        return [nav2.viewControllers lastObject];
        
    }else  if ([nav isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabvc = (UITabBarController *)nav;
        
        UIViewController * tabbarChildNav = [tabvc.viewControllers objectAtIndex:tabvc.selectedIndex];
        
        
        return [self currentViewController:tabbarChildNav];
    }
    
    return nav;
    
}

+(void) pushViewController:(UIViewController *) viewController
{
    [[self currentViewController].navigationController pushViewController:viewController animated:YES];
    
}

//设置图片透明度
#pragma mark- 对图片处理
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark- 对按钮的处理

+(void) button2Format:(UIButton *) button
{
    UIImage *buttonImg = [button imageForState:UIControlStateNormal];
    CGFloat titleWidth = [button.titleLabel.text sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:11],NSFontAttributeName, nil]].width;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(buttonImg.size.height + 5, -buttonImg.size.width, 0, 0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(-15, 0, 0, -titleWidth)];
}

//+(void) button2Format:(UIButton *) button imageToTitle:(CGFloat) delta 
//{
//    
//}


#pragma mark- 日期操作


+(NSString *) getWeekDayFromDate:(NSDate *) date
{
    NSArray *weekDay = [NSArray arrayWithObjects:@"",@"日",@"一",@"二",@"三",@"四",@"五",@"六", nil];
    //
    
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //    NSString *dateString = [dateFormatter stringFromDate:date];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit |
    NSMonthCalendarUnit |
    NSDayCalendarUnit |
    NSWeekdayCalendarUnit |
    NSHourCalendarUnit |
    NSMinuteCalendarUnit |
    NSSecondCalendarUnit;
    //int week=0;
    comps = [calendar components:unitFlags fromDate:date];
    int week = [comps weekday];
    
    NSLog(@"week = %d",week);
    return [weekDay objectAtIndex:week];
}


#pragma mark- 版本号处理
+(NSString *) versionName
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    return app_Version;//3.2.2
}

//+(NSString *) versionCode4UmengDemoUpdate
//{
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
//    return app_Version;
//}


@end
