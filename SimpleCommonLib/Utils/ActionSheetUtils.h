//
//  ActionSheetUtils.h
//  PalmHospital
//
//  Created by Chen on 15/2/2.
//  Copyright (c) 2015年 com.ylz. All rights reserved.
//


@interface ActionSheetUtils : NSObject


+(void) createActionSheetWithTitle:(NSString *) title delegate:(id) delegate OtherButtonArray:(NSMutableArray *) array;

+(void) createActionSheetWithTitle:(NSString *) title delegate:(id) delegate OtherButtonArray:(NSMutableArray *) array tag:(int) tag;

@end
