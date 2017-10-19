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

//
//
//self.simpleLayout = [[UICollectionViewFlowLayout alloc] init];
//
//self.simpleLayout.itemSize = CGSizeMake(100, 100); // Set size of cell
//self.simpleLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);  // "Border around each section"
//self.simpleLayout.minimumInteritemSpacing = 15;  // Minimum horizontal spacing between cells
//self.simpleLayout.minimumLineSpacing = 10;  // Minimum vertical spacing
//
////    // Add this line so headers will appear. If this line is not present, headers will not appear
////    self.simpleLayout.headerReferenceSize = CGSizeMake(self.collectionView.frame.size.width, 50);
//
//// By default, direction is vertical
//self.simpleLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//
//// Add this line so headers will appear. If this line is not present, headers will not appear
//self.simpleLayout.headerReferenceSize = CGSizeMake(50, self.collectionView.frame.size.height);
//
//// Add this line so footers will appear. If this line is not present, footers will not appear
//self.simpleLayout.footerReferenceSize = CGSizeMake(30, self.collectionView.frame.size.height);




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

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
