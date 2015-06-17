//
//  LibraryViewController.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface LibraryViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *photos;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

+ (ALAssetsLibrary *)defaultAssetsLibrary;

@end
