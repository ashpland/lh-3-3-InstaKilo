//
//  PhotoManager.h
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface PhotoManager : NSObject

@property (nonatomic, strong, readonly) NSArray<Photo *> *photosArray;

- (NSArray<Photo *> *)getPhotosForLocation:(PhotoLocations)location;
- (NSArray<Photo *> *)getPhotosForCategory:(PhotoCategories)category;
- (void)addAquariumPhotos;

@end
