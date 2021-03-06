//
//  SavedViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SavedViewController : UITableViewController {
    NSMutableArray *savedArray;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

- (IBAction)actionAdd:(UIBarButtonItem *)sender;
- (IBAction)actionEdit:(UIBarButtonItem *)sender;

@end
