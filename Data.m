//
//  Data.m
//  CustomCellApp
//
//  Created by Alexander Valdes on 10/14/16.
//  Copyright © 2016 Dase Inc. All rights reserved.
//

#import "Data.h"

@implementation Data

//Strings
@synthesize dataID, dataName, dataStatus1, dataStatus2, dataURL;

//Converting Strings into Objects
-(id)initWithDataName: (NSString *) dName
       andDataStatus1: (NSString *) dStatus1
       andDataStatus2: (NSString *) dStatus2
           andDataURL: (NSString *) dURL
            andDataID: (NSString *) dID
{
    self = [super init];
    
    if (self) {
        dataName = dName;
        dataStatus1 = dStatus1;
        dataStatus2 = dStatus2;
        dataURL = dURL;
        dataID = dID;
    }
    
    return self;
}

@end
