//
//  NSObject+MyAnnotation.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title, *subtitle;
@property (nonatomic) NSString *pointId;

- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end

