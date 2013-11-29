//
//  MovieViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/27/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "MovieViewController.h"

static CGFloat marginLeft = 20.0;
static CGFloat marginTop = 20.0;

// Title, Description, 
static CGFloat titleviewHeight = 80.0;
static CGFloat descriptionViewHeight = 200.0;
static CGFloat buttonViewHeight = 100.0;

// Label
static CGFloat titleLabelHeight = 30.0;
static CGFloat genreLabelHeight = 20.0;



// image
static CGFloat posterWidth = 100.0;
static CGFloat posterHeight = 148.0;
// button

static CGFloat buttonWidth = 130.0;
static CGFloat buttonHeight = 40.0;


@interface MovieViewController ()

@end

@implementation MovieViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    windowWidth = self.view.bounds.size.width;
    locationTableViewHeight = 220.0;
    
    // Initiate scroll view
    [scrollView setContentSize:CGSizeMake(windowWidth, titleviewHeight+descriptionViewHeight+buttonViewHeight+locationTableViewHeight+marginTop*2)];
    
    
    // Initiate UIViews
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, windowWidth, titleviewHeight)];
    [titleView setBackgroundColor:[UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0]];
    descriptionView = [[UIView alloc] initWithFrame:CGRectMake(0, titleviewHeight, windowWidth, descriptionViewHeight)];
    buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, titleviewHeight+descriptionViewHeight, windowWidth, buttonViewHeight)];
    locationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, titleviewHeight+descriptionViewHeight+buttonViewHeight, windowWidth, locationTableViewHeight)];
    
    // Title view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, marginTop, windowWidth-marginLeft*2, titleLabelHeight)];
    [titleLabel setText:@"Conan (2012)"];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20.0]];
    UILabel *genreLabel = [[UILabel alloc] initWithFrame:CGRectMake(marginLeft, titleLabelHeight+marginTop, windowWidth-marginLeft*2, genreLabelHeight)];
    [genreLabel setText:@"drama/cartoon"];
    [genreLabel setFont:[UIFont systemFontOfSize:14.0]];
    [titleView addSubview:titleLabel];
    [titleView addSubview:genreLabel];
    
    // Description view
    UIImageView *posterImageView = [[UIImageView alloc] initWithFrame:CGRectMake(marginLeft, marginTop, posterWidth, posterHeight)];
    [posterImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ia.media-imdb.com/images/M/MV5BMTQ0NDIyNzAzNF5BMl5BanBnXkFtZTcwOTcxNjYzMQ@@._V1_SY317_CR5,0,214,317_.jpg"]]]];
    UILabel *descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(posterWidth+2*marginLeft, marginTop, windowWidth-marginLeft*3-posterWidth, posterHeight)];
    [descriptionLabel setText:@"The cases of a detective whose physical age was chemically reversed to that of a prepubescent boy but must hide his true mental development."];
    [descriptionLabel setFont:[UIFont systemFontOfSize:14.0]];
    [descriptionLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [descriptionLabel setNumberOfLines:0];
    [descriptionView addSubview:posterImageView];
    [descriptionView addSubview:descriptionLabel];
    
    // Button View
    UIButton *imdbButton = [[UIButton alloc] initWithFrame:CGRectMake(marginLeft, marginTop, buttonWidth, buttonHeight)];
    [imdbButton setTitle:@"IMDb" forState:UIControlStateNormal];
    [imdbButton setBackgroundColor:[UIColor blueColor]];
    [imdbButton addTarget:self action:@selector(clickImdb:) forControlEvents:UIControlEventTouchUpInside];
    UIButton *trialButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth+marginLeft*2, marginTop, buttonWidth, buttonHeight)];
    [trialButton setTitle:@"Trial" forState:UIControlStateNormal];
    [trialButton setBackgroundColor:[UIColor blueColor]];
    [trialButton addTarget:self action:@selector(clickTrial:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:imdbButton];
    [buttonView addSubview:trialButton];
    
    
    // Table views
    [locationTableView setDataSource:self];
    [locationTableView setDelegate:self];
    [locationTableView setScrollEnabled:NO];
    
    // add the UIViews to scrollView
    [scrollView addSubview:titleView];
    [scrollView addSubview:descriptionView];
    [scrollView addSubview:buttonView];
    [scrollView addSubview:locationTableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Button click

- (void)clickImdb:(id)sender {
    NSLog(@"imdb");
}

- (void)clickTrial:(id)sender {
    NSLog(@"trial");
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = @"bkj";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
