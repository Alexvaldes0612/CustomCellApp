//
//  Data.h
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Data : NSObject

//Strings
@property (strong, nonatomic) NSString * dataName;
@property (strong, nonatomic) NSString * dataID;
@property (strong, nonatomic) NSString * dataStatus1;
@property (strong, nonatomic) NSString * dataStatus2;
@property (strong, nonatomic) NSString * dataURL;

#pragma mark -
#pragma mark Class Methods

// Converting Strings into Objects
-(id)initWithDataName: (NSString *) dName
       andDataStatus1: (NSString *) dStatus1
       andDataStatus2: (NSString *) dStatus2
           andDataURL: (NSString *) dURL
            andDataID: (NSString *) dID;

@end
