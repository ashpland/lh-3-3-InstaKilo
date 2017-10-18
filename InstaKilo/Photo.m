//
//  Photo.m
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "Photo.h"

@implementation Photo

- (instancetype)initWithID:(NSUInteger)uniqueID
{
    self = [super init];
    if (self) {
        _uniqueID = uniqueID;
        _image = [UIImage imageNamed:[NSString stringWithFormat:@"%lu", (unsigned long)uniqueID]];
    }
    return self;
}


@end
