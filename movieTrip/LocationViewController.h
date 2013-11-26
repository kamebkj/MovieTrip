//
//  LocationViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/22/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UITableViewController {
    NSString *locationName;
    NSArray *moviesArray;
    NSInteger selectedMovie;
    
    //    IBOutlet UITableView *tableViewOutlet;
}

@property (nonatomic, retain) NSString *locationId;

@end
