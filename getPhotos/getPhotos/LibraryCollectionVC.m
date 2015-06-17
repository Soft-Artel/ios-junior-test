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

@interface LibraryCollectionVC ()

@property (strong, nonatomic) NSArray *allPhotos;

@end

@implementation LibraryCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadPhotos];
//    CGFloat colum = 4.0, spacing = 2.0;
//    CGFloat value = floorf((CGRectGetWidth(self.view.bounds) - (colum - 1) * spacing) / colum);
//    UICollectionViewFlowLayout *layout  = [[UICollectionViewFlowLayout alloc] init];
//    layout.itemSize                     = CGSizeMake(value, value);
//    layout.sectionInset                 = UIEdgeInsetsMake(0, 0, 0, 0);
//    layout.minimumInteritemSpacing      = spacing;
//    layout.minimumLineSpacing           = spacing;
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    self.collectionView = [[UICollectionView alloc] initWithFrame:self.collectionView.frame collectionViewLayout:layout];
    [self.collectionView registerClass:[LibraryCollectionViewCell class] forCellWithReuseIdentifier:@"TWPhotoCollectionViewCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allPhotos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"TWPhotoCollectionViewCell";
    LibraryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    TWPhoto *photo = [self.allPhotos objectAtIndex:indexPath.row];
    cell.imageView.image = photo.thumbnailImage;
    return cell;
}

- (void)loadPhotos {
    [TWPhotoLoader loadAllPhotos:^(NSArray *photos, NSError *error) {
        if (!error) {
            self.allPhotos = [NSArray arrayWithArray:photos];
//            if (self.allPhotos.count) {
//                TWPhoto *firstPhoto = [self.allPhotos objectAtIndex:0];
//                [self.imageScrollView displayImage:firstPhoto.originalImage];
//            }
            [self.collectionView reloadData];
        } else {
            NSLog(@"Load Photos Error: %@", error);
        }
    }];
}

@end

