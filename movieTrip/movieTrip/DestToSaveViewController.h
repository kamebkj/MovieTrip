//
//  DestToSaveViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/26/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DestToSaveViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    __weak IBOutlet UITableView *myTableView;
    NSMutableArray *savedArray;
}

@property (nonatomic, retain) NSString *place;
@property (nonatomic, retain) NSString *placeId;

- (IBAction)clickCancel:(id)sender;

@end
