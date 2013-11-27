//
//  SearchViewController.m
//  movieTrip
//
//  Created by Kate Hsiao on 11/19/13.
//  Copyright (c) 2013 Kate Hsiao. All rights reserved.
//

#import "SearchViewController.h"
#import "AFNetworking.h"
#import "LocationViewController.h"

static NSString *const BaseURLString = @"http://people.ischool.berkeley.edu/~jthuang/i298/";

@interface SearchViewController ()

@end

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    locationArray = [[NSMutableArray alloc] init];
    movieArray = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UISearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self getAutoCompleteResult:searchString];
    return NO;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    return NO;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self getSearchResult:searchBar.text];
}

- (void)getAutoCompleteResult:(NSString*)str {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@search.php?type=all_auto&keyword=%@", BaseURLString, str];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self setSearchResultData:(NSDictionary*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
}

- (void)getSearchResult:(NSString*)str {
    NSString *weatherUrl = [NSString stringWithFormat:@"%@search.php?type=all&keyword=%@", BaseURLString, str];
    NSURL *url = [NSURL URLWithString:weatherUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFJSONRequestOperation *operation =
    [AFJSONRequestOperation JSONRequestOperationWithRequest:request
                                                    success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
                                                        [self setSearchResultData:(NSDictionary*)JSON];
                                                    }
                                                    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
                                                        NSLog(@"error");
                                                    }
     ];
    [operation start];
}

- (void)setSearchResultData:(NSDictionary*)dict {
    
    locationArray = [dict objectForKey:@"Locations"];
    movieArray = [dict objectForKey:@"Movies"];

    [self.searchDisplayController.searchResultsTableView reloadData];
}

#pragma mark - Table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([movieArray count]!=0 && [locationArray count]!=0) return 2;
    else if ([movieArray count]==0 && [locationArray count]==0) return 0;
    else return 1;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section==0 && [movieArray count]!=0) return @"Movie";
    else if (section==1 && [movieArray count]!=0)  return @"Location";
    else if (section==0 && [locationArray count]!=0) return @"Location";
    else return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0 && [movieArray count]!=0) return [movieArray count];
    else if (section==1 && [movieArray count]!=0)  return [locationArray count];
    else if (section==0 && [locationArray count]!=0) return [locationArray count];
    else return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LocationCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    if (indexPath.section==0 && [movieArray count]!=0) {
        cell.textLabel.text = [movieArray[indexPath.row] objectForKey:@"Title"];
    }
    else {
        cell.textLabel.text = [locationArray[indexPath.row] objectForKey:@"Description"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0 && [movieArray count]!=0) {
        NSLog(@"%@", [movieArray[indexPath.row] objectForKey:@"Movie_Id"]);
    }
    else {
//        NSLog(@"%@", [locationArray[indexPath.row] objectForKey:@"Location_Id"]);
        LocationViewController *locationVC = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:nil];
        locationVC.locationId = [locationArray[indexPath.row] objectForKey:@"Location_Id"];
        [self.navigationController pushViewController:locationVC animated:YES];
    }
    
}


@end
