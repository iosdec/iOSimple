//
//  iOSimple+UIMapView.m
//  iOSDec
//
//  Created by Declan Land
//  Copyright Declan Land. All rights reserved.
//

#import "iOSimple+UIMapView.h"

@implementation MKMapView (iOSimple_UIMapView)

BOOL alreadyZoomed;

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!self.delegate) {
        self.delegate = self;
    }
}

- (void)searchAndZoom:(NSString *)search {
    if (search.length == 0) { return; }
    [self geoCodeUsingAddress:search completion:^(CLPlacemark *placemark) {
        if (!placemark) { return; }
        [self zoomToLocation:placemark.location.coordinate];
        [self removeAllAnnotations];
        [self addAnnotationWithTitle:search location:placemark.location.coordinate];
    }];
}

- (void)zoomToLocation:(CLLocationCoordinate2D)location {
    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
    MKCoordinateRegion region = MKCoordinateRegionMake(location, span);
    [self setRegion:region animated:YES];
}

- (void)removeAllAnnotations {
    if (self.annotations.count == 0) { return; }
    [self removeAnnotations:self.annotations];
}

- (void)addAnnotationWithTitle:(NSString *)title location:(CLLocationCoordinate2D)location {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    if (title) {
        point.title = title;
    } [self addAnnotation:point];
}
- (void)addAnnotationWithTitle:(NSString *)title subtitle:(NSString *)subtitle location:(CLLocationCoordinate2D)location {
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = location;
    if (title) {
        point.title = title;
    }
    if (subtitle) {
        point.subtitle = subtitle;
    } [self addAnnotation:point];
}

#pragma mark    -   CLLocation:

- (void)zoomToCurrentLocation {
    [self setShowsUserLocation:YES];
    self.delegate               =   self;
    [[LocationManager sharedManager] fetchLocationWithCompletion:^(CLLocationCoordinate2D location) {
        [self zoomToLocation:location];
    }];
}

#pragma mark    -   MKMapView Delegate:

- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView {
    if (!alreadyZoomed) {
        [[LocationManager sharedManager] startUpdating];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (!alreadyZoomed) {
        [self zoomToLocation:userLocation.coordinate];
        alreadyZoomed = YES;
    }
}

#pragma mark    -   Convert Address:

- (void)geoCodeUsingAddress:(NSString *)address completion:(void(^)(CLPlacemark *placemark))completion {
    CLGeocoder *geoCoder        =   [[CLGeocoder alloc] init];
    [geoCoder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0) { completion(nil); return; }
        CLPlacemark *placemark  =   [placemarks firstObject];
        completion(placemark);
    }];
}

@end
