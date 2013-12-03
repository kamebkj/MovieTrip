//
//  MovieViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/27/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MovieViewController.h"
#import "LocationViewController.h"
#import "AFNetworking.h"
#import <QuartzCore/QuartzCore.h>

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";

static CGFloat marginLeft = 20.0;
static CGFloat marginTop = 20.0;

// UIView
static CGFloat titleviewHeight = 90.0;
static CGFloat descriptionViewHeight = 200.0;
static CGFloat buttonViewHeight = 80.0;

// Label
static CGFloat titleLabelHeight = 30.0;
static CGFloat genreLabelHeight = 20.0;

// Poster image
static CGFloat posterWidth = 100.0;
static CGFloat posterHeight = 148.0;

// Button
static CGFloat buttonWidth = 130.0;
static CGFloat buttonHeight = 40.0;


@interface MovieViewController ()

@end

@implementation MovieViewController
@synthesize movieId;

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

- (void)clickImdb:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [NSString stringWithFormat:@"http://www.imdb.com/title/%@", movieImdbId]]];
}

- (void)clickTrailer:(id)sender {
    NSLog(@"trial");
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([movieLocations count]>0) return @"Shooting Locations";
    else return @"Shooting locations not available";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [movieLocations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [movieLocations[indexPath.row] objectForKey:@"Description"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LocationViewController *locationVC = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
    locationVC.locationId = [movieLocations[indexPath.row] objectForKey:@"Location_Id"];
    [self.navigationController pushViewController:locationVC animated:YES];
    
}


#pragma mark - Get data

- (void)getData {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@movie.php?id=%@", BaseURLString, movieId];
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
    movieTitle = [dict objectForKey:@"Title"];
    movieYear = [dict objectForKey:@"Year"];
    movieDescription = [dict objectForKey:@"Description"];
    movieGenre = [dict objectForKey:@"Genre"];
    movieImdbId = [dict objectForKey:@"IMDb_Id"];
    moviePosterUrl = [dict objectForKey:@"Poster"];
    movieLocations = (NSMutableArray*)[dict objectForKey:@"Locations"];
    
    [self setViews];
}

- (void)setViews {
    
    
    windowWidth = self.view.bounds.size.width;
    locationTableViewHeight = [movieLocations count]*44+60;
    
    // Initiate scroll view
    [scrollView setContentSize:CGSizeMake(windowWidth, titleviewHeight+descriptionViewHeight+buttonViewHeight+locationTableViewHeight+marginTop)];
    [scrollView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];

    // Initiate UIViews
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, titleviewHeight)];
    [titleView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    UIView *titleBorder = [[UIView alloc] initWithFrame:CGRectMake(0, titleviewHeight-1, windowWidth, 1)];
    [titleBorder setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]];
    [titleView addSubview:titleBorder];
    
    descriptionView = [[UIView alloc] initWithFrame:CGRectMake(0, titleviewHeight, windowWidth, descriptionViewHeight)];
    [descriptionView setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0]];
    UIView *descriptionBorder = [[UIView alloc] initWithFrame:CGRectMake(0, descriptionViewHeight-1, windowWidth, 1)];
    [descriptionBorder setBackgroundColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.5]];
    [descriptionView addSubview:descriptionBorder];
    
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, titleviewHeight+descriptionViewHeight, windowWidth, buttonViewHeight)];
    [buttonView setBackgroundColor:[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1.0]];
    UIView *buttonBorder = [[UIView alloc] initWithFrame:CGRectMake(0, buttonViewHeight-1, windowWidth, 1)];
    [buttonBorder setBackgroundColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1.0]];
    [buttonView addSubview:buttonBorder];
    
    locationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleviewHeight+descriptionViewHeight+buttonViewHeight, windowWidth, locationTableViewHeight) style:UITableViewStyleGrouped];
    [locationTableView setBackgroundView:nil];
    [locationTableView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    
    
    // Title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, marginTop, windowWidth-marginLeft*2, titleLabelHeight)];
    [titleLabel setText:[NSString stringWithFormat:@"%@ %@", movieTitle, movieYear]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    UILabel *genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, titleLabelHeight+marginTop, windowWidth-marginLeft*2, genreLabelHeight)];
    [genreLabel setText:movieGenre];
    [genreLabel setFont:[UIFont systemFontOfSize:14.0]];
    [genreLabel setBackgroundColor:[UIColor clearColor]];
    [titleView addSubview:titleLabel];
    [titleView addSubview:genreLabel];
    
    // Description view
    UIImageView *posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft, marginTop, posterWidth, posterHeight)];
    if ([moviePosterUrl length]==0) {
        [posterImageView setImage:[UIImage imageNamed:@"movie-placeholder.png"]];
    }
    else {
        [posterImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:moviePosterUrl]]]];
    }
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(posterWidth+2*marginLeft, marginTop, windowWidth-marginLeft*3-posterWidth, posterHeight)];
    [descriptionLabel setText:movieDescription];
    [descriptionLabel setFont:[UIFont systemFontOfSize:14.0]];
    [descriptionLabel setBackgroundColor:[UIColor clearColor]];
    [descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [descriptionLabel setNumberOfLines:0];
    [descriptionLabel sizeToFit];
    if (descriptionLabel.frame.size.height>posterHeight) {
        [descriptionLabel setFrame:CGRectMake(posterWidth+2*marginLeft, marginTop, windowWidth-marginLeft*3-posterWidth, posterHeight)];
        [descriptionLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    }
    [descriptionView addSubview:posterImageView];
    [descriptionView addSubview:descriptionLabel];
    
    // Button View
    UIButton *imdbButton = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft, marginTop, buttonWidth, buttonHeight)];
    [imdbButton setTitle:@"IMDb" forState:UIControlStateNormal];
    [imdbButton setTitleColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0] forState:UIControlStateNormal];
    [imdbButton setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    [imdbButton setBackgroundColor:[UIColor clearColor]];
    [imdbButton.layer setBorderWidth:1.0];
    [imdbButton.layer setBorderColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0].CGColor];
    [imdbButton.layer setCornerRadius:5.0];
    [imdbButton addTarget:self action:@selector(clickImdb:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *trailerButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth+marginLeft*2, marginTop, buttonWidth, buttonHeight)];
    [trailerButton setTitle:@"Trailer" forState:UIControlStateNormal];
    [trailerButton setTitleColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0] forState:UIControlStateNormal];
    [trailerButton setTitleColor:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forState:UIControlStateHighlighted];
    [trailerButton setBackgroundColor:[UIColor clearColor]];
    [trailerButton.layer setBorderWidth:1.0];
    [trailerButton.layer setBorderColor:[UIColor colorWithRed:0.45 green:0.45 blue:0.45 alpha:1.0].CGColor];
    [trailerButton.layer setCornerRadius:5.0];
    [trailerButton addTarget:self action:@selector(clickTrailer:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:imdbButton];
    [buttonView addSubview:trailerButton];
    
    // Table views
    [locationTableView setDataSource:self];
    [locationTableView setDelegate:self];
    [locationTableView setScrollEnabled:NO];
    
    // add the UIViews to scrollView
    [scrollView addSubview:titleView];
    [scrollView addSubview:descriptionView];
    [scrollView addSubview:buttonView];
    [scrollView addSubview:locationTableView];
    
    [indicator stopAnimating];
}

@end
