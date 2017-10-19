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
#import "PhotoLayout.h"



@interface PhotoCollectionViewController ()

@property (nonatomic, strong) PhotoManager *photoManager;
@property (nonatomic, assign) PhotoSortOptions currentPhotoSort;
- (IBAction)photoSortChanged:(UISegmentedControl *)sender;
@property (nonatomic, strong) PhotoLayout *portraitLayout;
@property (nonatomic, strong) PhotoLayout *landscapeLayout;

@end

@implementation PhotoCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self doInitialSetup];
    [self listenForOrientationChanges];
}

- (void)doInitialSetup {
    self.photoManager = [PhotoManager new];
    [self.photoManager addSamplePhotos];
    self.currentPhotoSort = Default;
    self.portraitLayout = [[PhotoLayout alloc] initWithPhotosPerRow:3];
    self.landscapeLayout = [[PhotoLayout alloc] initWithPhotosPerRow:6];
    self.collectionView.collectionViewLayout = self.portraitLayout;
}

- (void)listenForOrientationChanges {
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter]
     addObserver:self selector:@selector(orientationChanged:)
     name:UIDeviceOrientationDidChangeNotification
     object:[UIDevice currentDevice]];
}

-(void)orientationChanged:(NSNotification *)notification {
    BOOL isDevicePortrait = (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation));
    self.collectionView.collectionViewLayout = isDevicePortrait ? self.portraitLayout : self.landscapeLayout;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self.photoManager numberOfSectionsInSort:self.currentPhotoSort];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.photoManager numberOfItemsInSection:section withSort:self.currentPhotoSort];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    cell.cellImageView.image = [self.photoManager getImageForPhotoIndex:indexPath.item
                                                              inSection:indexPath.section
                                                               withSort:self.currentPhotoSort];
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        HeaderCollectionReusableView *headerView =
        [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                withReuseIdentifier:@"MyHeaderView"
                                                       forIndexPath:indexPath];
        headerView.headerLabel.text = [self.photoManager getTitleForSection:indexPath.section withSort:self.currentPhotoSort];
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
