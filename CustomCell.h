//
//  CustomCell.h
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UIButton *followButton;
@property (weak, nonatomic) IBOutlet UIButton *followedButton;

@end
