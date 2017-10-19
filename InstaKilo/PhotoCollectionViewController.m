//
//  PhotoCollectionViewController.m
//  InstaKilo
//
//  Created by Andrew on 2017-10-18.
//  Copyright © 2017 Andrew. All rights reserved.
//

#import "PhotoCollectionViewController.h"
#import "PhotoManager.h"
#import "PhotoCollectionViewCell.h"
#import "HeaderCollectionReusableView.h"



@interface PhotoCollectionViewController ()

@property (nonatomic, strong) PhotoManager *photoManager;
@property (nonatomic, strong) UICollectionViewFlowLayout *defaultLayout;
@property (nonatomic, assign) PhotoSortOptions currentPhotoSort;
- (IBAction)photoSortChanged:(UISegmentedControl *)sender;

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.photoManager = [PhotoManager new];
    [self.photoManager addAquariumPhotos];
    
    self.currentPhotoSort = Default;
    
    
    [self setupLayout];
    self.collectionView.collectionViewLayout = self.defaultLayout;
}

- (void)setupLayout
{
    self.defaultLayout = [UICollectionViewFlowLayout new];
    
    CGFloat margin = 0;
    NSInteger imagesPerRow = 3;
    CGFloat width = (self.view.frame.size.width / imagesPerRow) - 2 * margin;
    
    self.defaultLayout.itemSize = CGSizeMake(width, width);
    self.defaultLayout.minimumInteritemSpacing = margin;
    self.defaultLayout.minimumLineSpacing = margin * 2;
   
    self.defaultLayout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, width / 4);

    self.defaultLayout.sectionHeadersPinToVisibleBounds = YES;
    
    self.defaultLayout.sectionInset = UIEdgeInsetsMake(0, 0, width / 2, 0);
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    switch (self.currentPhotoSort) {
        case Default:
            return 1;
        case Location:
            return [self.photoManager numberOfLocations];
        case Category:
            return [self.photoManager numberOfCategories];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (self.currentPhotoSort) {
        case Default:
            return self.photoManager.photosArray.count;
        case Location:
            return [self.photoManager getPhotosForLocation:section].count;
        case Category:
            return [self.photoManager getPhotosForCategory:section].count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImage *imageToAdd;
    
    switch (self.currentPhotoSort) {
        case Default:
            imageToAdd = self.photoManager.photosArray[indexPath.row].image;
            break;
        case Location:
            imageToAdd = [[self.photoManager getPhotosForLocation:indexPath.section] objectAtIndex:indexPath.row].image;
            break;
        case Category:
            imageToAdd = [[self.photoManager getPhotosForCategory:indexPath.section] objectAtIndex:indexPath.row].image;
            break;
    }
    
    cell.cellImageView.image = imageToAdd;
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"MyHeaderView"
                                                                                  forIndexPath:indexPath];
        
        
        NSString *sectionTitle;
        
        switch (self.currentPhotoSort) {
            case Default:
                sectionTitle = @"All Photos";
                break;
            case Location: {
                
                PhotoLocations location = indexPath.section;
                switch (location) {
                  
                    case Inside:
                        sectionTitle = @"Inside";
                        break;
                    case Outside:
                        sectionTitle = @"Outside";
                        break;
                }
                break;
            }
            case Category: {
                PhotoCategories category = indexPath.section;
                switch (category) {
                    
                    case Fish:
                        sectionTitle = @"Fish";
                        break;
                    case Mammals:
                        sectionTitle = @"Mammals";
                        break;
                    case Birds:
                        sectionTitle = @"Birds";
                        break;
                    case Amphibians:
                        sectionTitle = @"Amphibians";
                        break;
                    case Reptiles:
                        sectionTitle = @"Reptiles";
                        break;
                    case Invertebrates:
                        sectionTitle = @"Invertebrates";
                        break;
                    case Art:
                        sectionTitle = @"Art";
                        break;
                }
                break;
            }
        }
        
        headerView.headerLabel.text = sectionTitle;
        return headerView;
    }
    
    else {
        return nil;
    }
}




- (IBAction)photoSortChanged:(UISegmentedControl *)sender {
    self.currentPhotoSort = sender.selectedSegmentIndex;
    [self.collectionView reloadData];
}
@end
