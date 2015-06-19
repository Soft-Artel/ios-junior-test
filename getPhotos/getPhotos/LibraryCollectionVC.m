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

@property (strong, nonatomic) NSArray *allPhotos;

@end

@implementation LibraryCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPhotos];
    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize                     = CGSizeMake(100, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView.collectionViewLayout = layout;

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
    
#warning метод копирует метод из камеры - его лучше перенести в модель
    SelectedImages *images = [SelectedImages sharedInstance];
    [images.selectedImages addObject:photo.originalImage];
    if ([images.selectedImages count] == 3) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"3 photo ready" object:nil];
    }
}

- (void)loadPhotos
{
    [TWPhotoLoader loadAllPhotos:^(NSArray *photos, NSError *error) {
        if (!error) {
            self.allPhotos = [NSArray arrayWithArray:photos];
            [self.collectionView reloadData];
        } else {
            NSLog(@"Load Photos Error: %@", error);
        }
    }];
}

- (void)changeFrame:(CGRect)frame
{
    frame.origin = CGPointMake(0, 0);
    self.collectionView.frame = frame;
}

@end

