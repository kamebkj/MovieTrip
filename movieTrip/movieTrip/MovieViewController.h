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
    
    // Dynamic size
    CGFloat windowWidth;
    CGFloat locationTableViewHeight;
}

@end
