//
//  Photo.h
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

typedef NS_ENUM(NSUInteger, PhotoCategories) {
    NoCategory,
    Fish,
    Mammals,
    Birds,
    Amphibians,
    Invertebrates,
};

typedef NS_ENUM(NSUInteger, PhotoLocations) {
    NoLocation,
    Inside,
    Outside,
};


@interface Photo : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, assign) PhotoCategories category;
@property (nonatomic, assign) PhotoLocations location;
@property (nonatomic, assign) NSUInteger uniqueID;


- (instancetype)initWithID:(NSUInteger)uniqueID;


@end
