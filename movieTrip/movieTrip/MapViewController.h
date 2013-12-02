//
//  MapViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController <MKMapViewDelegate, MKAnnotation> {
    CLLocationCoordinate2D location;
    Boolean didDrawAnnotation;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end
