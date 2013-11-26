//
//  MapViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MapViewController.h"
#import "LocationViewController.h"
#import "AFNetworking.h"
#import "MyAnnotation.h"

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";

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
    // Get user current location
//    CLLocationCoordinate2D location = [[[self.mapView userLocation] location] coordinate];
//    NSLog(@"Location found from Map: %f %f",location.latitude,location.longitude);
    CLLocationCoordinate2D location;
    location.latitude = 35.026267;
    location.longitude = 135.751904;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 1000000, 1000000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:NO];
    
    // GET data, give paras of location & ?
    // if success, then draw annotation
    if (!didDrawAnnotation) {
        [self getNearbyData];
    }
        
}

- (void)drawAnnotation:(NSArray*)points {
    
    for (int i=0; i<[points count]; i++) {
        CLLocationCoordinate2D coord;
        coord.latitude = [[points[i] objectForKey:@"Latitude"] doubleValue];
        coord.longitude = [[points[i] objectForKey:@"Longitude"] doubleValue];
        
        MyAnnotation *point = [[MyAnnotation alloc] initWithLocation:coord];
        point.title = [points[i] objectForKey:@"Description"];
        point.pointId = [points[i] objectForKey:@"Location_Id"];
//        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//        point.coordinate = coord;
//        point.title = [points[i] objectForKey:@"Description"];

        [self.mapView addAnnotation:point];
    }
    
    didDrawAnnotation = true;
}

- (void)getNearbyData {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@nearby.php?lat=35.026267&lon=135.751904&dist=1000000&num=30", BaseURLString];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self drawAnnotation:(NSArray*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
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
//    [rightButton addTarget:self action:@selector(showDetail:) forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = rightButton;
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    LocationViewController *locationVC = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    MyAnnotation *ano = (MyAnnotation*)view.annotation;
    locationVC.locationId = ano.pointId;
    [self.navigationController pushViewController:locationVC animated:YES];
}



- (void)showDetail:(id)sender {
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
