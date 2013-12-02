//
//  MovieViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/27/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UIView *titleView;
    UIView *descriptionView;
    UIView *buttonView;
    UITableView *locationTableView;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIActivityIndicatorView *indicator;
    
    // Dynamic size
    CGFloat windowWidth;
    CGFloat locationTableViewHeight;
    
    // Movie data GET
    NSString *movieTitle;
    NSString *movieYear;
    NSString *movieDescription;
    NSString *movieGenre;
    NSString *movieImdbId;
    NSString *moviePosterUrl;
    NSMutableArray *movieLocations;
}

@property (retain, nonatomic) NSString *movieId;

@end
