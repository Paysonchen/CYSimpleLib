//
//  AlertViewUtils.h
//  heyuanjiaotong
//
//  Created by 陈 燕鹏 on 12-10-21.
//  Copyright (c) 2012年 Easepal. All rights reserved.
//


#define DefTitle @"提示"
#define DefCancel @"确定"

@interface AlertViewUtils : NSObject



/**
 *  创建AlertView,并传递message 
 *  默认Title为 DefTitle
 *  默认Cancel 为 DefCancel
 *
 *  @param message  需要展示在Alertview 文字内容
 */
+ (id) createAlertViewWithMessage:(NSString *) message;


/**
 *  创建AlertView,并传递message 及 delegate
 *  默认Title为 DefTitle
 *  默认Cancel 为 DefCancel
 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param message  需要展示在Alertview 文字内容
 */
+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message;

/**
 *  创建AlertView,并传递message 及 delegate 及 CancelButtonTtitle
 *  默认Title为 DefTitle
 
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param message  需要展示在Alertview 文字内容
 *  @param cancel   唯一的一个Button 展示的文字
 */
+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel;


/**
 *  创建AlertView,并传递message 及 delegate 及 title
 *  默认Cancel 为 DefCancel
 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param title    AlertView title
 *  @param message  需要展示在Alertview 文字内容
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message;


/**
 *  创建AlertView,并传递message 、 delegate 、 title 、cancel

 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param title    AlertView title
 *  @param message  需要展示在Alertview 文字内容
 *  @param cancel   唯一的一个Button 展示的文字
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel;

/**
 *  创建AlertView,并传递message 、 delegate 、 title、cancelButtonTitle、otherButtonTitle
 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param title    AlertView title
 *  @param message  需要展示在Alertview 文字内容
 *  @param cancelButtonTitle 第一个 Button 展示的文字
 *  @param otherButtonTitle  第二个 Button 展示的文字
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle;
/*
 带tag
 */


/**
 *  创建AlertView,并传递message 及 delegate 及 tag
 *  默认Title为 DefTitle
 *  默认Cancel 为 DefCancel
 
 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param message  需要展示在Alertview 文字内容
 *  @param tag      标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate Message:(NSString *) message tag:(int) tag; //tag可以




/**
 *  创建AlertView,并传递message 、 delegate 、 title 、tag
 *  默认Cancel 为 DefCancel
 *
 *  @param delegate AlertView 点击事件回调到具体的实例
 *  @param title    AlertView title
 *  @param message  需要展示在Alertview 文字内容
 *  @param tag      标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message tag:(int) tag;

/**
 *  创建AlertView,并传递message 、 delegate 、 title 、cancel 、tag

 *
 *  @param delegate  AlertView 点击事件回调到具体的实例
 *  @param title    AlertView title
 *  @param message  需要展示在Alertview 文字内容
 *  @param cancel   第一个 Button 展示的文字
 *  @param tag      标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancel tag:(int) tag;

/**
 *  创建AlertView,并传递message 、 delegate 、 title 、cancelButtonTitle 、otherButtonTitle、tag

 *
 *  @param delegate          AlertView 点击事件回调到具体的实例
 *  @param title             AlertView title
 *  @param message           需要展示在Alertview 文字内容
 *  @param cancelButtonTitle 第一个 Button 展示的文字
 *  @param otherButtonTitle  第二个 Button 展示的文字
 *  @param tag               标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle tag:(int) tag;



/**
 *  创建AlertView,并传递message 、 delegate  、cancelButtonTitle 、otherButtonTitle、tag
 *
 *  @param delegate          AlertView 点击事件回调到具体的实例
 *  @param message           需要展示在Alertview 文字内容
 *  @param cancelButtonTitle 第一个 Button 展示的文字
 *  @param otherButtonTitle  第二个 Button 展示的文字
 *  @param tag               标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate  Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitles:(NSString *) otherButtonTitle tag:(int) tag;


/**
 *  创建AlertView,并传递message 、 delegate 、title 、cancelButtonTitle 、otherButtonTitle、tag
 *
 *  @param delegate          AlertView 点击事件回调到具体的实例
 *  @param title             AlertView title
 *  @param message           需要展示在Alertview 文字内容
 *  @param cancelButtonTitle 第一个 Button 展示的文字
 *  @param otherButtonTitles  第2~n个 Button 展示的文字
 *  @param tag               标识AlertView 多个回调区分
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitlesArray:(NSMutableArray *) otherButtonTitles tag:(int) tag;


/**
 *  创建AlertView,并传递message 、 delegate 、title 、cancelButtonTitle 、otherButtonTitle、tag
 *
 *  @param delegate          AlertView 点击事件回调到具体的实例
 *  @param title             AlertView title
 *  @param message           需要展示在Alertview 文字内容
 *  @param cancelButtonTitle 第一个 Button 展示的文字
 *  @param otherButtonTitles  第2~n个 Button 展示的文字
 *  @param tag               标识AlertView 多个回调区分
 *  @param style             可定制的风格,输入框、一般文本
 */
+ (id) createAlertViewWithDelegate:(id) delegate Title:(NSString *) title Message:(NSString *) message CancelButtonTtitle: (NSString *)cancelButtonTitle OtherButtonTitlesArray:(NSMutableArray *) otherButtonTitles tag:(int) tag style:(UIAlertViewStyle ) style;
@end
