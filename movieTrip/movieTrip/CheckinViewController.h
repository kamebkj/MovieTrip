//
//  CheckinViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 12/3/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface CheckinViewController : UIViewController <MKMapViewDelegate, MKAnnotation> {
    __weak IBOutlet MKMapView *mapView;
}

@property (nonatomic, assign) CLLocationCoordinate2D location;

- (IBAction)clickCancel:(id)sender;

@end
