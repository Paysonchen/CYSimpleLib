//
//  LocationUtils.m
//  MicroDriver
//
//  Created by Chen on 14-9-1.
//  Copyright (c) 2014年 . All rights reserved.
//

#import "LocationUtils.h"

#define LOCATED_CITY @"LOCATED_CITY"
#define LOCATED_PROVINCE @"LOCATED_PROVINCE"

#define iOS8 ([[[UIDevice currentDevice] systemVersion] doubleValue]>=8.0?YES:NO)


@implementation LocationUtils
+ (LocationUtils *)sharedClient
{
    
    
    static LocationUtils *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[LocationUtils alloc] init];
    });
    
    return _sharedClient;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //
        self.locationManager = [[CLLocationManager alloc] init];
        
        if (iOS8) {
            //
//            [_locationManager requestAlwaysAuthorization];
            [_locationManager requestWhenInUseAuthorization];
        }
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;
        [_locationManager startUpdatingLocation];
        
        
        
        
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        self.city = [ud objectForKey:LOCATED_CITY];
        self.province = [ud objectForKey:LOCATED_PROVINCE];
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied)
    {
        NSLog(@" 访问被拒绝 ");
    }
    if ([error code] == kCLErrorLocationUnknown) {
        //
        NSLog(@" 无法获取位置信息 ");

    }
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationDidUpdateNotification object:nil];

}

-(void)locationManager:(CLLocationManager *)manager didFinishDeferredUpdatesWithError:(NSError *)error
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LocationDidUpdateNotification object:nil];

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"locations : %@",locations);
    for (CLLocation *l in locations) {
        //
        NSLog(@"location latitude = %f",l.coordinate.latitude);
        NSLog(@"location longitude = %f",l.coordinate.longitude);
        
        self.lat = l.coordinate.latitude;
        self.lon = l.coordinate.longitude;
        
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation: l completionHandler:^(NSArray *array, NSError *error) {
            if (array.count > 0) {
                CLPlacemark *placemark = [array objectAtIndex:0];
                NSString *country = placemark.ISOcountryCode;
                NSString *city = placemark.locality;
                NSString *name = placemark.name;
                NSString *thoroughfare = placemark.thoroughfare;
                NSString *subLocality = placemark.subLocality;
                NSString *subThoroughfare = placemark.subThoroughfare;
                
                NSString *administrativeArea = placemark.administrativeArea;
                NSString *subAdministrativeArea = placemark.subAdministrativeArea;
                NSString *inlandWater = placemark.inlandWater;
                NSLog(@"administrativeArea = %@",administrativeArea);
                NSLog(@"subAdministrativeArea = %@",subAdministrativeArea);
                NSLog(@"inlandWater = %@",inlandWater);

//                NSLog(@"array = %@",array);

                NSLog(@"country = %@",country);
                NSLog(@"city = %@",city);
                NSLog(@"name = %@",name);
                NSLog(@"thoroughfare = %@",thoroughfare);
                NSLog(@"subLocality = %@",subLocality);
                NSLog(@"subThoroughfare = %@",subThoroughfare);
                
                NSMutableString *addr = [[NSMutableString alloc] init];
                [addr appendString:city];
                [addr appendString:subLocality];
                [addr appendString:thoroughfare?thoroughfare:@""];
                [addr appendString:subThoroughfare?subThoroughfare:@""];
//                [addr appendString:name?name:@""];
                self.locatedAddr = addr;
                self.province = administrativeArea;
                self.city = city;
                
                
                NSUserDefaults *ud= [NSUserDefaults standardUserDefaults];
                [ud setObject:_city forKey:LOCATED_CITY];
                [ud setObject:_province forKey:LOCATED_PROVINCE];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LocationDidUpdateNotification object:nil];
                
//                self.locatedAddr = [NSString stringWithFormat:@"%@%@%@%@%@",city,subLocality,thoroughfare,subThoroughfare,name];
            }
        }];
        
    }
    
    [_locationManager stopUpdatingLocation];
    

}



@end
