//
//  SelectedImagesCollectionVC.m
//  getPhotos
//
//  Created by test on 19.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "SelectedImagesCollectionVC.h"
#import "SelectedImagesCell.h"
#import "SelectedImages.h"
#import "ImageVC.h"

@interface SelectedImagesCollectionVC () 
{
    NSMutableArray *images;
}

@end

@implementation SelectedImagesCollectionVC

- (id)init
{
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(150, 200);
    self = [super initWithCollectionViewLayout:layout];
    return self;
}

static NSString *const reuseIdentifier = @"SelectedImagesCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.editButtonItem.title = @"OK";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem.rightBarButtonItem setAction:@selector(endButtonPressed)];
    [self.collectionView registerClass:[SelectedImagesCell class] forCellWithReuseIdentifier:reuseIdentifier];

    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [self.collectionView addGestureRecognizer:swipeDown];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.collectionView setHidden:NO];
    images = [SelectedImages sharedInstance].selectedImages;
    [self.collectionView reloadData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [images count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SelectedImagesCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imageView.image =  [images objectAtIndex:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIImage *image = [images objectAtIndex:indexPath.row];
    ImageVC *imageVC = [[ImageVC alloc] initWithImage:image];
    [self.navigationController pushViewController:imageVC animated:YES];
    [self.collectionView setHidden:YES];
}

- (void)endButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)swipeHandle:(UISwipeGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    SelectedImagesCell *cell = (SelectedImagesCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:0.5 animations:^{
        cell.imageView.frame = CGRectOffset(cell.imageView.frame, 0, 600);
        cell.imageView.frame = CGRectOffset(cell.imageView.frame, 0, -600);
    }];
    [self.collectionView performBatchUpdates:^{
        NSArray *selectedItemsIndexPaths = [NSArray arrayWithObject:indexPath];
        [[SelectedImages sharedInstance].selectedImages removeObjectAtIndex:indexPath.row];
        images = [SelectedImages sharedInstance].selectedImages;
        [self.collectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
    } completion:nil];
}

@end
