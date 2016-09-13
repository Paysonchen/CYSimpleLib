//
//  LocationUtils.h
//  MicroDriver
//
//  Created by Chen on 14-9-1.
//  Copyright (c) 2014年  All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#define LocationDidUpdateNotification @"LocationDidUpdateNotification"

@interface LocationUtils : NSObject<CLLocationManagerDelegate>
+ (LocationUtils *)sharedClient;

@property (strong) CLLocationManager *locationManager;

/**
 *  纬度 例如北纬23
 */
@property (assign) CGFloat lat;

/**
 *  经度 例如东经120
 */
@property (assign) CGFloat lon;


/**
 *  定位的具体地址，省市县区借到……
 */
@property(strong) NSString *locatedAddr;

/**
 *  省份
 */
@property(strong) NSString *province;

/**
 *  城市
 */
@property(strong) NSString *city;
@end
