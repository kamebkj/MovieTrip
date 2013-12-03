//
//  LocationViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 12/1/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "LocationViewController.h"
#import "MovieViewController.h"
#import "DestToSaveViewController.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "FacebookSDK.framework/Headers/FacebookSDK.h"

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";

static CGFloat marginLeft = 20.0;
static CGFloat marginTop = 20.0;

// UIView
static CGFloat pictureViewHeight = 200.0;
static CGFloat titleViewHeight = 60.0;
static CGFloat buttonViewHeight = 80.0;

// Label
static CGFloat titleLabelHeight = 30.0;

// Button
static CGFloat buttonWidth = 130.0;
static CGFloat buttonHeight = 40.0;

@interface LocationViewController ()

@end

@implementation LocationViewController
@synthesize locationId;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [indicator startAnimating];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button click

- (void)clickCheckin:(id)sender {
    NSLog(@"checkin");
    // If a user has *never* logged into your app, request one of
    // "email", "user_location", or "user_birthday". If you do not
    // pass in any permissions, "email" permissions will be automatically
    // requested for you. Other read permissions can also be included here.
    
    // can include any of the "publish" or "manage" permissions
//    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", nil];
//    
//    [[FBSession activeSession] requestNewPublishPermissions:permissions
//                                            defaultAudience:FBSessionDefaultAudienceFriends
//                                          completionHandler:^(FBSession *session, NSError *error) {
//                                              /* handle success + failure in block */
//                                              NSLog(@"session: %@", session);
//                                              NSLog(@"error: %@", error);
//                                          }];
    
}

- (void)clickSave:(id)sender {
    DestToSaveViewController *destToSaveVC = [[DestToSaveViewController alloc] initWithNibName:@"DestToSaveViewController" bundle:nil];
    destToSaveVC.place = locationTitle;
    destToSaveVC.placeId = locationId;
    [self.navigationController presentViewController:destToSaveVC animated:YES completion:nil];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([locationMovies count]>0) return @"Movies shot here";
    else return @"No movies shot here";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [locationMovies count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MovieCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [locationMovies[indexPath.row] objectForKey:@"Title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MovieViewController *movieVC = [[MovieViewController alloc] initWithNibName:@"MovieViewController" bundle:nil];
    movieVC.movieId = [locationMovies[indexPath.row] objectForKey:@"Movie_Id"];
    [self.navigationController pushViewController:movieVC animated:YES];
    
}


#pragma mark - Get data

- (void)getData {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@location.php?id=%@", BaseURLString, locationId];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self setData:(NSDictionary*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
}

- (void)setData:(NSDictionary*)dict {
    
    locationTitle = [dict objectForKey:@"Description"];
    locationLati = [dict objectForKey:@"Latitude"];
    locationLong = [dict objectForKey:@"Longitude"];
    locationPicture = [dict objectForKey:@"Image"];
    locationMovies = (NSMutableArray*)[dict objectForKey:@"Movies"];
    
    [self setViews];
}

- (void)setViews {
    
    
    windowWidth = self.view.bounds.size.width;
    movieTableViewHeight = [locationMovies count]*44+60;
    
    // Initiate scroll view
    [scrollView setContentSize:CGSizeMake(windowWidth, pictureViewHeight+titleViewHeight+buttonViewHeight+movieTableViewHeight)];
    [scrollView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    
    // Initiate UIViews
    pictureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, pictureViewHeight)];
    if ([locationPicture length]==0) {
        [pictureView setImage:[UIImage imageNamed:@"location-placeholder.png"]];
    }
    else {
        [pictureView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:locationPicture]]]];
    }
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, pictureViewHeight, windowWidth, titleViewHeight)];
    [titleView setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0]];

    buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, pictureViewHeight+titleViewHeight, windowWidth, buttonViewHeight)];
    [buttonView setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0]];
    UIView *buttonBorder = [[UIView alloc] initWithFrame:CGRectMake(0, buttonViewHeight-1, windowWidth, 1)];
    [buttonBorder setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]];
    [buttonView addSubview:buttonBorder];
    
    movieTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, pictureViewHeight+titleViewHeight+buttonViewHeight, windowWidth, movieTableViewHeight) style:UITableViewStyleGrouped];
    [movieTableView setBackgroundView:nil];
    [movieTableView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    
    
    // Title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, marginTop, windowWidth-marginLeft*2, titleLabelHeight)];
    [titleLabel setText:locationTitle];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:titleLabel];
    
    // Button View
    UIButton *checkinButton = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft, marginTop, buttonWidth, buttonHeight)];
    [checkinButton setTitle:@"CheckIn" forState:UIControlStateNormal];
    [checkinButton setTitleColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0] forState:UIControlStateNormal];
    [checkinButton setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    [checkinButton setBackgroundColor:[UIColor clearColor]];
    [checkinButton.layer setBorderWidth:1.0];
    [checkinButton.layer setBorderColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0].CGColor];
    [checkinButton.layer setCornerRadius:5.0];
    [checkinButton addTarget:self action:@selector(clickCheckin:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *saveButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth+marginLeft*2, marginTop, buttonWidth, buttonHeight)];
    [saveButton setTitle:@"Save to Fav" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0] forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    [saveButton setBackgroundColor:[UIColor clearColor]];
    [saveButton.layer setBorderWidth:1.0];
    [saveButton.layer setBorderColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0].CGColor];
    [saveButton.layer setCornerRadius:5.0];
    [saveButton addTarget:self action:@selector(clickSave:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:checkinButton];
    [buttonView addSubview:saveButton];
    
    // Table views
    [movieTableView setDataSource:self];
    [movieTableView setDelegate:self];
    [movieTableView setScrollEnabled:NO];
    
    // add the UIViews to scrollView
    [scrollView addSubview:pictureView];
    [scrollView addSubview:titleView];
    [scrollView addSubview:buttonView];
    [scrollView addSubview:movieTableView];
    
    [indicator stopAnimating];
}


@end
