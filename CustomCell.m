//
//  CustomCell.m
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell
@synthesize firstStatusLabel, secondStatusLabel, myImageView, followButton, followedButton;

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
