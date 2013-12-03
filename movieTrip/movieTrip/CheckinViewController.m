//
//  CheckinViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 12/3/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "CheckinViewController.h"

@interface CheckinViewController ()

@end

@implementation CheckinViewController
@synthesize location;

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

//    CLLocationCoordinate2D location;
//    location.latitude = [locationLati doubleValue];
//    location.longitude = [locationLong doubleValue];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location, 100, 100);
    [mapView setRegion:[mapView regionThatFits:region] animated:NO];
    [mapView setUserInteractionEnabled:NO];
//    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
//    point.coordinate = location;
//    [mapView addAnnotation:point];
    
    UIImageView *dialog = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 280, 112)];
    [dialog setImage:[UIImage imageNamed:@"checkin-dialog"]];
    [mapView addSubview:dialog];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
