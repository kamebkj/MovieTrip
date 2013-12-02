//
//  LocationViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 12/1/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    UIImageView *pictureView;
    UIView *titleView;
    UIView *buttonView;
    UITableView *movieTableView;
    __weak IBOutlet UIScrollView *scrollView;
    __weak IBOutlet UIActivityIndicatorView *indicator;
    
    // Dynamic size
    CGFloat windowWidth;
    CGFloat movieTableViewHeight;
    
    // Location data GET
    NSString *locationTitle;
    NSString *locationLati;
    NSString *locationLong;
    NSString *locationPicture;
    NSMutableArray *locationMovies;
}

@property (retain, nonatomic) NSString *locationId;

@end
