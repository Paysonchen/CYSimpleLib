//
//  BaseView.h
//  MicroDriver
//
//  Created by Chen on 14-8-22.
//  Copyright (c) 2014年 . All rights reserved.
//

#import <UIKit/UIKit.h>

#define VIEW_TAG 9999
@interface BaseView : UIView

/**
 *  与同名xib进行匹配，需要在xib中设置类型。
 */
-(void) loadXIB;
@end
