//
//  PhotoManager.m
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "PhotoManager.h"

@interface PhotoManager ()

@property (nonatomic, strong) NSMutableArray<Photo *> *photosArray;
@property (nonatomic, assign) NSUInteger numberOfCategories;
@property (nonatomic, assign) NSUInteger numberOfLocations;

@end

@implementation PhotoManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _photosArray = [NSMutableArray new];
        _numberOfLocations = 2;
        _numberOfCategories = 6; //this is intentionally 6 to exclude the Art photo
    }
    return self;
}


# pragma mark - Photo Adding and Editing Methods

- (void)addPhotoWithID:(NSUInteger)uniqueID
{
    Photo *newPhoto = [[Photo alloc] initWithID:uniqueID];
    [self.photosArray addObject:newPhoto];
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



# pragma mark - External Methods

- (UIImage *)getImageForPhotoIndex:(NSInteger)index inSection:(NSInteger)section withSort:(PhotoSortOptions)sort {
    return [[self getPhotosForSection:section withSort:sort] objectAtIndex:index].image;
}

-(NSString *)getTitleForSection:(NSInteger)section withSort:(PhotoSortOptions)sort {
    switch (sort) {
        case Default:
            return @"All Photos";
        case Location:
            return [self getLocationName:section];
        case Category:
            return [self getCategoryName:section];
    }
}

-(NSInteger)numberOfSectionsInSort:(PhotoSortOptions)sort {
    switch (sort) {
        case Default:
            return 1;
        case Location:
            return self.numberOfLocations;
        case Category:
            return self.numberOfCategories;
    }
}

-(NSInteger)numberOfItemsInSection:(NSInteger)section withSort:(PhotoSortOptions)sort {
    return [self getPhotosForSection:section withSort:sort].count;
}


# pragma mark - Internal Methods


-(NSArray<Photo *> *)getPhotosForSection:(NSInteger)section withSort:(PhotoSortOptions)sort
{
    if (sort == Default) {
        return self.photosArray;
    }
    
    NSMutableArray<Photo *> *sectionPhotos = [NSMutableArray new];
    for (Photo *curPhoto in self.photosArray) {
        switch (sort) {
            case Location:
                if (curPhoto.location == section)
                    [sectionPhotos addObject:curPhoto];
                break;
            case Category:
                if (curPhoto.category == section)
                    [sectionPhotos addObject:curPhoto];
                break;
            default:
                break;
        }
    }
    
    return sectionPhotos;
}

-(NSString *)getLocationName:(PhotoLocations)location
{
    switch (location) {
        case Inside:
            return @"Inside";
        case Outside:
            return @"Outside";
    }
}

-(NSString *)getCategoryName:(PhotoCategories)category
{
    switch (category) {
        case Fish:
            return @"Fish";
        case Mammals:
            return @"Mammals";
        case Birds:
            return @"Birds";
        case Amphibians:
            return @"Amphibians";
        case Reptiles:
            return @"Reptiles";
        case Invertebrates:
            return @"Invertebrates";
        case Art:
            return @"Art";
    }
}

-(void)addSamplePhotos
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

@end
