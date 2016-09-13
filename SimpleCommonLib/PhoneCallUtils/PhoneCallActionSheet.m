//
//  PhoneCallActionSheet.m
//  tianxian
//
//  Created by 陈燕鹏 on 13-5-29.
//  Copyright (c) 2013年 com.ylz. All rights reserved.
//

#import "PhoneCallActionSheet.h"

@implementation PhoneCallActionSheet

- (id)initWithPhoneNum:(NSString *) number delegate:(id) delegate
{
    self = [super initWithTitle:@"拨打电话" delegate:delegate cancelButtonTitle:@"取消" destructiveButtonTitle:[NSString stringWithFormat:@"拨打:%@",number] otherButtonTitles:nil, nil];
    if (self) {
        //
        UIViewController *vc = delegate;
        [self setActionSheetStyle:UIActionSheetStyleAutomatic];
        [self showInView:vc.view];

    }
    return self;
}

+(void) showActionSheetWithPhoneNum:(NSString *) number delegate:(id) delegate
{
    PhoneCallActionSheet *sheet = [[PhoneCallActionSheet alloc] initWithPhoneNum:number delegate:delegate];
    
    sheet.tag = ACTION_SHEET_TAG_PHONE_CALL;
    [sheet setActionSheetStyle:UIActionSheetStyleAutomatic];
    UIViewController *vc = delegate;

    [sheet showInView:vc.view];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
