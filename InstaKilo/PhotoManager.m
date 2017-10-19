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
    for (NSUInteger uniqueID = 1; uniqueID < 40; uniqueID++) {
        [self addPhotoWithID:uniqueID];
    }
}

-(NSArray<Photo *> *)photosArray
{
    return self.internalPhotosArray;
}

@end
