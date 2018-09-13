//
//  LocationManager.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager : NSObject

+ (id)sharedManager {
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    }); return _sharedObject;
}

- (void)fetchLocationWithCompletion:(void (^)(CLLocationCoordinate2D location))location {
    [self setCompletion:location];
    self.locManager                 =   [[CLLocationManager alloc] init];
    self.locManager.delegate        =   self;
    self.locManager.desiredAccuracy =   kCLLocationAccuracyBest;
    [self.locManager requestWhenInUseAuthorization];
    [self.locManager requestLocation];
}

- (void)startUpdating {
    if (!self.locManager) { self.locManager = [[CLLocationManager alloc] init]; }
    [self.locManager startUpdatingLocation];
}

#pragma mark    -   CLLocationManager Delegate:

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusAuthorizedAlways) {
        [manager requestAlwaysAuthorization];
    }
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [manager requestWhenInUseAuthorization];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    //  lcoation failed to update
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (locations.count != 0) {
        CLLocation *firstLocation = [locations firstObject];
        [self.locManager stopUpdatingLocation];
        [self.locManager stopMonitoringSignificantLocationChanges];
        self.locManager = nil;
        if (self.completion) {
            self.completion(firstLocation.coordinate);
        }
    }
}

#pragma mark    -   Geo Coder:

- (void)addressToPlacemark:(NSString *)address completion:(void(^)(CLPlacemark *placemark))completion {
    CLGeocoder *geoCoder        =   [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0) { completion(nil); return; }
        CLPlacemark *placemark  =   [placemarks firstObject];
        completion(placemark);
    }];
}

- (void)locationToAddress:(CLLocation *)location completion:(void(^)(CLPlacemark *placemark))completion {
    
    //  try with the current positioning of the lat / long
    //  if that don't work.. then switch them
    
    CLGeocoder *geoCoder        =   [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if (placemarks.count != 0) {
            CLPlacemark *placemark  =   [placemarks firstObject];
            completion(placemark); return;
        }
        
        //  try with second..
        
        CLLocation *second_location =   [[CLLocation alloc] initWithLatitude:location.coordinate.longitude longitude:location.coordinate.latitude];
        
        CLGeocoder *second_coder    =   [[CLGeocoder alloc] init];
        [second_coder reverseGeocodeLocation:second_location completionHandler:^(NSArray<CLPlacemark *> * _Nullable second_placemarks, NSError * _Nullable second_error) {
            
            if (second_placemarks.count != 0) {
                CLPlacemark *place  =   [second_placemarks firstObject];
                completion(place); return;
            }
            
            completion(nil);
            
        }];
        
    }];
    
}

- (void)distanceFromLocation:(CLLocation *)fromLocation toLocation:(CLLocation *)toLocation completion:(void (^)(CLLocationDistance))completion {
    completion([toLocation distanceFromLocation:fromLocation]);
}

@end
