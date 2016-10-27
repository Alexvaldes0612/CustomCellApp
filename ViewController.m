//
//  ViewController.m
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import "ViewController.h"
#import "Data.h"
#import "CustomCell.h"
#import "Settings.h"
#import <SDWebImage/UIImageView+WebCache.h>

// Server URL (For Testing)
#define getDataURL @"http://79.170.40.227/gamenotify.org/json.php"

@interface ViewController ()
@end

@implementation ViewController
@synthesize myTableView, mySearchBar, jsonArray, dataArray, filteredArray, isFiltered, followedArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Custom Cell
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    
    // Allocating Array
    followedArray = [[NSMutableArray alloc] init];
    
    // Search Bar
    mySearchBar.delegate = self;
    
    // Dismissing Keyboard
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [myTableView addGestureRecognizer:gestureRecognizer];
    
    // Load Data
    [self retrieveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// Gets the number of rows by counting the arrays
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (!isFiltered) {
        
        if (section == 0) {
            return [followedArray count];
        }
        else if (section == 1) {
            return [dataArray count];
        }
    }
    return [filteredArray count];
    
}

// Title for Section Headers
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Followed Data";
    }
    else {
        return @"All Data";
    }
}

// Height of row
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 140;
}

// Setting up the cells in the rows *Main*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Coloring TableView
    myTableView.backgroundColor = [UIColor redColor];
    cell.backgroundColor = [UIColor redColor];
    
    // Configuring the cell
    Data * dataObject;
    if (!isFiltered) {
        
        if (indexPath.section == 0) {
            dataObject = [followedArray objectAtIndex:indexPath.row];
        }
        else if (indexPath.section == 1) {
            dataObject = [dataArray objectAtIndex:indexPath.row];
        }
    }
    else {
        dataObject = [filteredArray objectAtIndex:indexPath.row];
    }
    
    // Loading Images
    if (!isFiltered) {
        // Exception Breakpoint Here
        NSURL * imgURL = [[dataArray objectAtIndex:indexPath.row] valueForKey:@"dataURL"];
        [cell.myImageView setContentMode:UIViewContentModeScaleAspectFit];
        [cell.myImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"no-image.png"] options:SDWebImageRefreshCached];
    }else{
        NSURL * imgURL = [[filteredArray objectAtIndex:indexPath.row] valueForKey:@"dataURL"];
        [cell.myImageView setContentMode:UIViewContentModeScaleAspectFit];
        [cell.myImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"no-image.png"] options:SDWebImageRefreshCached];
    }
    
    // Loading DataStatus Labels
    cell.firstStatusLabel.text = dataObject.dataStatus1;
    cell.secondStatusLabel.text = dataObject.dataStatus2;
    cell.firstStatusLabel.hidden = NO; // yes
    cell.secondStatusLabel.hidden = NO; // yes
    
    // Loading Follow Button
    cell.followButton.tag = indexPath.row;
    [cell.followButton addTarget:self action:@selector(followButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.followButton.hidden = NO;
    
    // Loading Followed Button
    cell.followedButton.tag = indexPath.row;
    [cell.followedButton addTarget:self action:@selector(followedButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.followedButton.hidden = YES;
    
    return cell;
}

#pragma mark -
#pragma mark Class Methods

// Hiding Keyboard
-(void)hideKeyboard {
    [self.view endEditing:NO];
}

-(IBAction)settingsButton:(id)sender {
}

// Search Bar
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length == 0) {
        isFiltered = NO;
    } else {
        isFiltered = YES;
        
        filteredArray = [[NSArray alloc] init];
        NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"self.dataName contains[c] %@", searchText];
        filteredArray = [dataArray filteredArrayUsingPredicate:resultPredicate];
        
    }
    [self.myTableView reloadData];
}

// Search Bar Clicked
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [mySearchBar resignFirstResponder];
}

// Follow Button Clicked
-(void)followButtonClick:(UIButton *)sender {
    
    // Adding row to tag
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    
    // Creating an action per tag
    if (indexPath != nil)
    {
        //NSLog(@"Current Row = %@", indexPath);
        
        // Showing Status Labels
        CustomCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        cell.firstStatusLabel.hidden = NO;
        cell.secondStatusLabel.hidden = NO;
        
        // Change Follow to Following
        [sender setImage:[UIImage imageNamed:@"follow.png"] forState:UIControlStateNormal];
        cell.followButton.hidden = YES;
        cell.followedButton.hidden = NO;
        
        
        // ----- ERROR HERE ----- ( Add if statement to see if its [search bar] or [all data] )
        [self.myTableView beginUpdates];
        
        // ----- Inserting Cell to Section 0 ----- *NOT WORKING*
        // Exception Breakpoint Here
        [followedArray addObject:[dataArray objectAtIndex:indexPath.row]];
        [myTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:followedArray.count-1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        
        NSLog(@"indexPath.row = %ld", (long)indexPath.row);
        
        // ----- Removing Cell from Section 1 ----- *WORKING*
        [dataArray removeObjectAtIndex:indexPath.row];
        NSInteger rowToRemove = indexPath.row;
        [self.myTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObjects:[NSIndexPath indexPathForRow:rowToRemove inSection:1], nil] withRowAnimation:YES];
        
        NSLog(@"Array =%@",followedArray);
        
        [self.myTableView endUpdates];
    }
}

// Followed Button Clicked
-(void)followedButtonClick:(UIButton *)sender {
    
    // Adding row to tag
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.myTableView];
    NSIndexPath *indexPath = [self.myTableView indexPathForRowAtPoint:buttonPosition];
    
    // Creating an action per tag
    if (indexPath != nil)
    {
        NSLog(@"Current Row = %@", indexPath);
        
        // Hiding Status Labels
        CustomCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        cell.firstStatusLabel.hidden = YES;
        cell.secondStatusLabel.hidden = YES;
        
        // Change Following to Follow
        [sender setImage:[UIImage imageNamed:@"followed.png"] forState:UIControlStateNormal];
        cell.followButton.hidden = NO;
        cell.followedButton.hidden = YES;
        
        // Haven't implement the reverse of followButtonClick
    }
}

// Connecting to server to get data
-(void)retrieveData {
    NSURL * url = [NSURL URLWithString:getDataURL];
    NSData * data = [NSData dataWithContentsOfURL:url];
    
    jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    
    // Setting up data array
    dataArray = [[NSMutableArray alloc] init];
    
    // Looping through jsonArray
    for (int i = 0; i < jsonArray.count; i++) {
        
        // Create Data Object
        NSString * dID = [[jsonArray objectAtIndex:i] objectForKey:@"id"];
        NSString * dName = [[jsonArray objectAtIndex:i] objectForKey:@"dataName"];
        NSString * dStatus1 = [[jsonArray objectAtIndex:i] objectForKey:@"dataStatus1"];
        NSString * dStatus2 = [[jsonArray objectAtIndex:i] objectForKey:@"dataStatus2"];
        NSString * dURL = [[jsonArray objectAtIndex:i] objectForKey:@"dataURL"];
        
        // Add Data Objects to Data Array
        [dataArray addObject:[[Data alloc] initWithDataName:dName andDataStatus1:dStatus1 andDataStatus2:dStatus2 andDataURL:dURL andDataID:dID]];
    }
    
    [self.myTableView reloadData];
}

@end
