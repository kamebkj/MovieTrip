//
//  MapViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MapViewController.h"
#import "LocationViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.mapView.delegate = self;
    didDrawAnnotation = false;
}

- (void)viewDidAppear:(BOOL)animated {
    CLLocationCoordinate2D location = [[[self.mapView userLocation] location] coordinate];
    NSLog(@"Location found from Map: %f %f",location.latitude,location.longitude);
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
    
    // GET data, give paras of location & ?
    // if success, then draw annotation
    if (!didDrawAnnotation) [self drawAnnotation];
}

- (void)drawAnnotation {
    // Add an annotation
    CLLocationCoordinate2D coord;
    coord.latitude = 37.872057;
    coord.longitude = -122.257829;
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = coord;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
    
    didDrawAnnotation = true;
}


//- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
//{
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
//    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
//}

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {

    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *annotationIdentifier = @"AnnotationIdentifier";
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationIdentifier];
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorPurple;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = rightButton;
    
    return pinView;
}

- (void)showDetail:(id)sender {
    NSLog(@"bkj");
//    LocationViewController *locationVC = [[LocationViewController alloc] init];
    LocationViewController *locationVC = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    [self.navigationController pushViewController:locationVC animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
