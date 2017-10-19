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
        _numberOfLocations = 2;
        _numberOfCategories = 6;
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
    
    NSArray<NSNumber *> *outsidePhotos = @[@15, @20, @21, @22, @23, @24, @25, @26, @27, @28, @29, @30, @31, @0];
    
    [self addLocation:Outside toPhotos:outsidePhotos];
    
    NSArray<NSNumber *> *mammals = @[@15, @20, @21, @22, @23, @24, @25, @26, @27, @31, @37, @38];
    NSArray<NSNumber *> *birds = @[@28, @29, @30];
    NSArray<NSNumber *> *amphibians = @[@1];
    NSArray<NSNumber *> *reptiles = @[@34];
    NSArray<NSNumber *> *invertebrates = @[@5, @8, @11, @12, @13, @14, @35, @36];
    NSArray<NSNumber *> *art = @[@0];

    [self addCategory:Mammals toPhotos:mammals];
    [self addCategory:Birds toPhotos:birds];
    [self addCategory:Amphibians toPhotos:amphibians];
    [self addCategory:Reptiles toPhotos:reptiles];
    [self addCategory:Invertebrates toPhotos:invertebrates];
    [self addCategory:Art toPhotos:art];

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
