//
//  GetImageViewController.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "GetImageVC.h"
#import "CameraVC.h"
#import "LibraryCollectionVC.h"

@interface GetImageVC ()
{
    CameraVC *camera;
    LibraryCollectionVC *library;
}

@end

@implementation GetImageVC

@synthesize cameraView, libraryView, captureImageButton, changeCameraButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    camera = [[CameraVC alloc] initWithNibName:@"CameraVC" bundle:nil];
    [cameraView addSubview:camera.view];
    library = [[LibraryCollectionVC alloc] initWithNibName:@"LibraryCollectionVC" bundle:nil];
    [libraryView addSubview:library.collectionView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)captureImage:(id)sender
{
    captureImageButton.enabled = changeCameraButton.enabled = NO;
    [camera snapImage];
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [camera newPhoto];
        captureImageButton.enabled = changeCameraButton.enabled = YES;
    });
    //[library.collectionView reloadData];
}

- (IBAction)changeCamera:(id)sender
{
    [camera changeCamera];
}

@end
