//
//  NSObject+MyAnnotation.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
- (id)initWithLocation: (CLLocationCoordinate2D) coord {
    self = [super init];
    if (self) {
        self->_coordinate = coord;
    }
    return self;
}
@end