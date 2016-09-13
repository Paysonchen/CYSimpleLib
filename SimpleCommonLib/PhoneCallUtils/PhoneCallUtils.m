//
//  PhoneCallUtils.m
//  PalmHospital
//
//  Created by Chen on 15/2/4.
//  Copyright (c) 2015年 com.ylz. All rights reserved.
//

#import "PhoneCallUtils.h"
#import "AlertViewUtils.h"

@implementation PhoneCallUtils

+(void) makeAPhoneCallWithDelegate:(id) delegate phoneNum:(NSString*) phonenum
{
    //    NSString *number = phonenum;// 此处读入电话号码
    
    // NSString *num = [[NSString alloc] initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法 结束电话之后会进入联系人列表
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",phonenum]; //而这个方法则打电话前先弹框  是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:num]])
    {
        //
        NSLog(@"能打开就打开");
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    }else
    {
        [AlertViewUtils createAlertViewWithDelegate:self Message:@"您的设备不支持拨打电话的功能"];
    }
}
@end
