//
//  PhotoManager.h
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

typedef NS_ENUM(NSUInteger, PhotoSortOptions) {
    Default,
    Location,
    Category,
};


@interface PhotoManager : NSObject



- (UIImage *)getImageForPhotoIndex:(NSInteger)index inSection:(NSInteger)section withSort:(PhotoSortOptions)sort;
- (NSString *)getTitleForSection:(NSInteger)section withSort:(PhotoSortOptions)sort;
- (NSInteger)numberOfSectionsInSort:(PhotoSortOptions)sort;
- (NSInteger)numberOfItemsInSection:(NSInteger)section withSort:(PhotoSortOptions)sort;




- (void)addSamplePhotos;

@end
