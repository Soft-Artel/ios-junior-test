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
#import "SelectedImages.h"
#import "SelectedImagesCollectionVC.h"

@interface GetImageVC ()
{
    CameraVC *camera;
    LibraryCollectionVC *library;
    CGRect gestureViewFrame;
    CGRect libraryViewFrame;
    SelectedImagesCollectionVC *selectedImagesCVC;
}

@property (strong, nonatomic) IBOutlet UIView *gestureView;

@end

@implementation GetImageVC

@synthesize cameraView, libraryView, gestureView, captureImageButton, changeCameraButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.editButtonItem.title = @"OK";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.navigationItem.rightBarButtonItem setAction:@selector(endButtonPressed)];
    
    selectedImagesCVC = [[SelectedImagesCollectionVC alloc] init];
    
    camera = [[CameraVC alloc] initWithNibName:@"CameraVC" bundle:nil];
    [camera changeFrame:cameraView.frame];
    [cameraView addSubview:camera.view];
    
    library = [[LibraryCollectionVC alloc] initWithNibName:@"LibraryCollectionVC" bundle:nil];
    [library changeFrame:libraryView.frame];
    [libraryView addSubview:library.collectionView];
    
    UIPanGestureRecognizer *swipeChanging = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideUpWithGestureRecognizer:)];
    [self.gestureView addGestureRecognizer:swipeChanging];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    gestureViewFrame = gestureView.frame;
    libraryViewFrame = libraryView.frame;
    [library changeFrame:libraryViewFrame];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setImages)
        name:@"4 photo ready" object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"4 photo ready" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)captureImage:(id)sender
{
    if ([SelectedImages sharedInstance].selectedImages.count <= 3) {
        captureImageButton.enabled = changeCameraButton.enabled = NO;
        [camera snapImage];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [camera newPhoto];
            [library loadPhotos];
            captureImageButton.enabled = changeCameraButton.enabled = YES;
        });
    } else {
        [[SelectedImages sharedInstance] showAlert];
    }
}

- (IBAction)changeCamera:(id)sender
{
    [camera changeCamera];
}

- (IBAction)watchSelectedImages:(id)sender
{
    [self.navigationController pushViewController:selectedImagesCVC animated:YES];
}

- (void)endButtonPressed
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)slideUpWithGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer
{
    CGPoint translate = [gestureRecognizer translationInView:self.view];
    CGRect newFrameGesture = gestureViewFrame;
    newFrameGesture.origin.y += translate.y;
    if (newFrameGesture.origin.y < 340) {
        newFrameGesture.origin.y = 340;
    } else if (newFrameGesture.origin.y > 500) {
        newFrameGesture.origin.y = 500;
    }
    gestureView.frame = newFrameGesture;
    
    CGRect newFrameLibrary = libraryViewFrame;
    newFrameLibrary.origin.y += translate.y;
    newFrameLibrary.size.height -= translate.y;
    if (newFrameLibrary.origin.y < 360) {
        newFrameLibrary.origin.y = 360;
        newFrameLibrary.size.height = 160;
    } else if (newFrameLibrary.origin.y > 520) {
        newFrameLibrary.origin.y = 520;
        newFrameLibrary.size.height = 0;
    }
    libraryView.frame = newFrameLibrary;
    if (libraryView.frame.size.height > 50) {
        [library changeFrame:libraryView.frame];
    }
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        gestureViewFrame = gestureView.frame;
        libraryViewFrame = libraryView.frame;
    }
}

- (void)setImages
{
    [self.navigationController pushViewController:selectedImagesCVC animated:YES];
}

@end
