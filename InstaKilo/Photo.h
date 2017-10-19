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
    Fish,
    Mammals,
    Birds,
    Amphibians,
    Reptiles,
    Invertebrates,
    Art,
};

typedef NS_ENUM(NSUInteger, PhotoLocations) {
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
