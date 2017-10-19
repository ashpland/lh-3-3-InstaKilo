//
//  PhotoManager.m
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "PhotoManager.h"

@interface PhotoManager ()

@property (nonatomic, strong) NSMutableArray<Photo *> *internalPhotosArray;

@end

@implementation PhotoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalPhotosArray = [NSMutableArray new];
    }
    return self;
}

- (void)addPhotoWithID:(NSUInteger)uniqueID
{
    Photo *newPhoto = [[Photo alloc] initWithID:uniqueID];
    [self.internalPhotosArray addObject:newPhoto];
}

-(void)addAquariumPhotos
{
    for (NSUInteger uniqueID = 0; uniqueID < 39; uniqueID++) {
        [self addPhotoWithID:uniqueID];
    }
    
    NSArray<NSNumber *> *indoorPhotos = @[@1, @2, @3];
    
    [self addLocation:Inside toPhotos:indoorPhotos];
    
    NSLog(@"%@", [self getPhotosForLocation:Inside]);
}

-(void)addLocation:(PhotoLocations)location toPhotos:(NSArray<NSNumber *> *)list
{
    for (NSNumber *photoNumber in list) {
        [self.photosArray objectAtIndex:[photoNumber unsignedIntegerValue]].location = location;
    }
}
-(void)addCategory:(PhotoCategories)category toPhotos:(NSArray<NSNumber *> *)list
{
    for (NSNumber *photoNumber in list) {
        [self.photosArray objectAtIndex:[photoNumber unsignedIntegerValue]].category = category;
    }
}

-(NSArray<Photo *> *)photosArray
{
    return self.internalPhotosArray;
}

-(NSArray<Photo *> *)getPhotosForCategory:(PhotoCategories)category
{
    NSMutableArray<Photo *> *categoryPhotos = [NSMutableArray new];
    for (Photo *curPhoto in self.photosArray) {
        if (curPhoto.category == category) {
            [categoryPhotos addObject:curPhoto];
        }
    }
    return categoryPhotos;
}

-(NSArray<Photo *> *)getPhotosForLocation:(PhotoLocations)location
{
    NSMutableArray<Photo *> *locationPhotos = [NSMutableArray new];
    for (Photo *curPhoto in self.photosArray) {
        if (curPhoto.location == location) {
            [locationPhotos addObject:curPhoto];
        }
    }
    return locationPhotos;
}



@end
