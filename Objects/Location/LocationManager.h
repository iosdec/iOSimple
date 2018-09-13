//
//  LocationManager.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationManager : NSObject <CLLocationManagerDelegate>

typedef void (^completion) (CLLocationCoordinate2D location);
@property (nonatomic, copy) completion completion;
@property (strong, nonatomic) CLLocationManager *locManager;

+ (id)sharedManager;
- (void)fetchLocationWithCompletion:(void(^)(CLLocationCoordinate2D location))location;
- (void)startUpdating;
- (void)addressToPlacemark:(NSString *)address completion:(void(^)(CLPlacemark *placemark))completion;
- (void)locationToAddress:(CLLocation *)location completion:(void(^)(CLPlacemark *placemark))completion;
- (void)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation completion:(void(^)(CLLocationDistance distance))completion;

@end
