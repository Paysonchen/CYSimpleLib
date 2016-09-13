//
//  ActionSheetUtils.m
//  PalmHospital
//
//  Created by Chen on 15/2/2.
//  Copyright (c) 2015年 com.ylz. All rights reserved.
//

#import "ActionSheetUtils.h"

@implementation ActionSheetUtils
+(void) createActionSheetWithTitle:(NSString *) title delegate:(id) delegate OtherButtonArray:(NSMutableArray *) array
{
    [ActionSheetUtils createActionSheetWithTitle:title delegate:delegate OtherButtonArray:array tag:0];
    
}
+(void) createActionSheetWithTitle:(NSString *) title delegate:(id) delegate OtherButtonArray:(NSMutableArray *) array tag:(int) tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title delegate:delegate cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    

    for (NSString *title in array) {
        [actionSheet addButtonWithTitle:title];
    }
    [actionSheet addButtonWithTitle:@"取消"];
    
    actionSheet.cancelButtonIndex = actionSheet.numberOfButtons -1;
    

    actionSheet.tag = tag;
    [actionSheet showInView: [[[UIApplication sharedApplication] delegate] window]];

    
}
@end
