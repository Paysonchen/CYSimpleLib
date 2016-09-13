;
//
//  AlertViewUtils.m
//  heyuanjiaotong
//
//  Created by 陈 燕鹏 on 12-10-21.
//  Copyright (c) 2012年 Easepal. All rights reserved.
//

#import "AlertViewUtils.h"
//#import "CommonAlertView.h"
@implementation AlertViewUtils


/*
 不带tag
 */

+ (id) createAlertViewWithMessage:(NSString *) message
{
    return [self createAlertViewWithDelegate:nil Message:message];
}

+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message
{
    return [self createAlertViewWithDelegate:delegate Title:nil Message:message];
}

+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel
{
    return [self createAlertViewWithDelegate:delegate Title:nil Message:message CancelButtonTtitle:cancel];

}

+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message
{
    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:nil];
}


+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel
{
    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:cancel OtherButtonTitles:nil];
}

+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle
{
    
    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:cancelButtonTitle OtherButtonTitles:otherButtonTitle tag:-1];
}

/*
 * 带tag
 */
+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message tag:(int) tag
{
    return [self createAlertViewWithDelegate:delegate Title:nil Message:message tag:tag];
}

+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message tag:(int) tag
{

    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:nil tag:tag];
}

+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel tag:(int) tag
{
    return [self createAlertViewWithDelegate:delegate Title:nil Message:message CancelButtonTtitle:cancel tag:tag];
    
}


+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel tag:(int) tag
{
    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:cancel OtherButtonTitles:nil tag:tag];
}

+ (id) createAlertViewWithDelegate:(id) delegate  Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle tag:(int) tag
{
    return [self createAlertViewWithDelegate:delegate Title:nil Message:message CancelButtonTtitle:cancelButtonTitle OtherButtonTitles:otherButtonTitle tag:tag];

}

+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle tag:(int) tag
{
    
    return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:cancelButtonTitle  OtherButtonTitlesArray:otherButtonTitle == nil?nil:[NSMutableArray arrayWithObject:otherButtonTitle] tag:tag];
    //    PP_RELEASE(AlertView);
}







+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitlesArray:(NSMutableArray *) otherButtonTitles tag:(int) tag
{
     return [self createAlertViewWithDelegate:delegate Title:title Message:message CancelButtonTtitle:cancelButtonTitle OtherButtonTitlesArray:otherButtonTitles tag:tag style:UIAlertViewStyleDefault];
}


+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitlesArray:(NSMutableArray *) otherButtonTitles tag:(int) tag style:(UIAlertViewStyle ) style
{
    
    NSString *_title,*_message,*_cancelButtonTitle;
    _title = title == nil?@"提示":title;
    if (message == nil || [message isEqualToString:@""]) {
        _message = @"";
        //        return;//没信息直接不弹对话框了
    }else
    {
        _message = message;
    }
    
    _cancelButtonTitle = cancelButtonTitle == nil?@"确定":cancelButtonTitle;
    
    //CommonAlertView
    UIAlertView *AlertView = [[UIAlertView alloc] initWithTitle:_title message:_message delegate:delegate cancelButtonTitle:_cancelButtonTitle otherButtonTitles: nil];
    
    
    AlertView.alertViewStyle = style;
    
    NSLog(@"otherButtonTitles = %@",otherButtonTitles);
    
    for (NSString *title in otherButtonTitles) {
        [AlertView addButtonWithTitle:title];
    }
    if (tag == -1) {
    }else
    {
        AlertView.tag = tag;
    }
    
    AlertView.tintColor = [UIColor greenColor];
    
//    [NSThread detachNewThreadSelector:@selector(show) toTarget:AlertView withObject:nil];
    [AlertView show];
    
    if ([delegate isKindOfClass:[UIViewController class]]) {
        //        BaseViewController *bvc = (BaseViewController *)delegate;
        //        [bvc.mBaseAlertView addObject:AlertView];;//PP_RETAIN(AlertView);
    }
//    [AlertView release];

    return AlertView;
}


@end
