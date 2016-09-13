//
//  PhoneCallActionSheet.h
//  tianxian
//
//  Created by 陈燕鹏 on 13-5-29.
//  Copyright (c) 2013年 com.ylz. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ACTION_SHEET_TAG_PHONE_CALL 1000

@interface PhoneCallActionSheet : UIActionSheet
- (id)initWithPhoneNum:(NSString *) number delegate:(id) delegate;

+(void) showActionSheetWithPhoneNum:(NSString *) number delegate:(id) delegate;
@end
