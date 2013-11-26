//
//  SavedListViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/25/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedListViewController : UITableViewController {
    NSArray *places;
}

@property (retain, nonatomic) NSDictionary *savedTripDict;

@end
