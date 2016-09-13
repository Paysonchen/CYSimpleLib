//
//  CommonMacro.h
//  CommonLib
//
//  Created by Chen on 15/7/27.
//  Copyright (c) 2015年 YlzInfo. All rights reserved.
//

#ifndef CommonLib_CommonMacro_h
#define CommonLib_CommonMacro_h


#pragma mark- Color

/**
 *  rgb to UIColor
 *
 *  @param r red value
 *  @param g green value
 *  @param b blue value
 *
 *  @return UIColor
 */
#define RGB(r, g, b) RGBA(r, g, b, 1.0)

/**
 *  rgba to UIColor
 *
 *  @param r red value
 *  @param g green value
 *  @param b blue value
 *  @param a apha value
 *
 *  @return UIColor
 */
#define RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#define HEX_COLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



#pragma mark- Frame
#define WINDOW_WIDTH  [[[UIApplication sharedApplication] delegate] window].frame.size.width
#define WINDOW_HEIGHT  [[[UIApplication sharedApplication] delegate] window].frame.size.height

#endif
