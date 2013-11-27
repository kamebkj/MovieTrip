//
//  MovieViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UITableViewController {
    NSString *movieName;
    NSArray *locationsArray;
//    NSInteger selectedMovie;
}

@property (nonatomic, retain) NSString *movieId;

@end
