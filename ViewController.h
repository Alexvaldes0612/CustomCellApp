//
//  ViewController.h
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *mySearchBar;

@property (nonatomic, strong) NSMutableArray * jsonArray;
@property (nonatomic, strong) NSMutableArray * dataArray;

@property (nonatomic, strong) NSMutableArray * followedArray;
@property (nonatomic, strong) NSArray * filteredArray;

@property (nonatomic) BOOL isFiltered;

#pragma mark -
#pragma mark Class Methods

-(void)retrieveData;
-(void)followButtonClick:(UIButton *)sender;
-(void)followedButtonClick:(UIButton *)sender;
-(void)hideKeyboard;
-(IBAction)settingsButton:(id)sender;

@end

