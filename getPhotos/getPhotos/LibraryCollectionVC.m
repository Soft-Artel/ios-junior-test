//
//  LibraryCollectionViewController.m
//  getPhotos
//
//  Created by test on 17.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "LibraryCollectionVC.h"
#import "LibraryCollectionViewCell.h"
#import "TWPhotoLoader.h"
#import "TWPhoto.h"
#import "SelectedImages.h"

@interface LibraryCollectionVC ()
{
    UICollectionViewFlowLayout *layout;
}

@property (strong, nonatomic) NSArray *allPhotos;

@end

@implementation LibraryCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self loadPhotos];
    [self.collectionView registerClass:[LibraryCollectionViewCell class] forCellWithReuseIdentifier:@"TWPhotoCollectionViewCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.allPhotos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TWPhotoCollectionViewCell";
    LibraryCollectionViewCell *libraryCell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    TWPhoto *photo = [self.allPhotos objectAtIndex:indexPath.row];
    libraryCell.imageView.image = photo.thumbnailImage;
    return libraryCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    TWPhoto *photo = [self.allPhotos objectAtIndex:indexPath.row];
    if ([SelectedImages sharedInstance].selectedImages.count <= 3) {
        [[SelectedImages sharedInstance] saveImage:photo.originalImage];
    } else {
        [[SelectedImages sharedInstance] showAlert];
    }
}

- (void)loadPhotos
{
    [[TWPhotoLoader sharedLoader] startLoading];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(waitForData) name:@"Objects ready" object:nil];
}

- (void)changeFrame:(CGRect)frame
{
    frame.origin = CGPointMake(0, 0);
    self.collectionView.frame = frame;
    CGFloat imageSize = frame.size.height*0.8;
    layout.itemSize = CGSizeMake(imageSize, imageSize);
    self.collectionView.collectionViewLayout = layout;
}

- (void)waitForData
{
    self.allPhotos = [TWPhotoLoader sharedLoader].allPhotos;
    [self.collectionView reloadData];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Objects ready" object:nil];
    [TWPhotoLoader sharedLoader].allPhotos = [NSMutableArray new];
}

@end

