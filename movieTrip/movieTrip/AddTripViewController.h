//
//  AddTripViewController.h
//  movieTrip
//
//  Created by Kate Hsiao on 11/25/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTripViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UITextField *descText;


- (IBAction)actionCancel:(id)sender;
- (IBAction)actionDone:(id)sender;

@end
