//
//  iOSimple+UIMapView.h
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "LocationManager.h"

@interface MKMapView (iOSimple_UIMapView) <CLLocationManagerDelegate, MKMapViewDelegate>

- (void)searchAndZoom:(NSString *)search;
- (void)geoCodeUsingAddress:(NSString *)address completion:(void(^)(CLPlacemark *placemark))completion;
- (void)removeAllAnnotations;
- (void)zoomToLocation:(CLLocationCoordinate2D)location;
- (void)zoomToCurrentLocation;
- (void)addAnnotationWithTitle:(NSString *)title location:(CLLocationCoordinate2D)location;
- (void)addAnnotationWithTitle:(NSString *)title subtitle:(NSString *)subtitle location:(CLLocationCoordinate2D)location;

@end
