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

@interface PhotoCollectionViewController ()

@property (nonatomic, strong) PhotoManager *photoManager;
@property (nonatomic, strong) UICollectionViewFlowLayout *defaultLayout;

@end

@implementation PhotoCollectionViewController

static NSString * const reuseIdentifier = @"PhotoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    self.photoManager = [PhotoManager new];
    [self.photoManager addAquariumPhotos];
    
    [self setupLayout];
    self.collectionView.collectionViewLayout = self.defaultLayout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setupLayout
{
    self.defaultLayout = [UICollectionViewFlowLayout new];
    
    CGFloat margin = 0;
    NSInteger imagesPerRow = 4;
    CGFloat width = (self.view.frame.size.width / imagesPerRow) - 2 * margin;
    
    self.defaultLayout.itemSize = CGSizeMake(width, width);
    self.defaultLayout.minimumInteritemSpacing = margin;
    self.defaultLayout.minimumLineSpacing = margin * 2;
   

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
    return 1;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photoManager.photosArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.cellImageView.image = self.photoManager.photosArray[indexPath.row].image;
    
    return cell;
}


//- (void)temp
//{
//
//                                                                                forIndexPath:indexPath];
//    NSString *labelText = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
//    cell.label.text = labelText;
//
//    return cell;
//}



#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
