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
    CGRect gestureViewFrame;
    CGRect libraryViewFrame;
}

@property (strong, nonatomic) IBOutlet UIView *gestureView;

@end

@implementation GetImageVC

@synthesize cameraView, libraryView, captureImageButton, changeCameraButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    gestureViewFrame = self.gestureView.frame;
    libraryViewFrame = self.libraryView.frame;
    
#warning Тут это делать не правильно - при viewDidLoad фрейма еще нет - те он есть но не реальный а из ниба, если у тебя 6+ а ниб под 4ку - все попплывет
    
    camera = [[CameraVC alloc] initWithNibName:@"CameraVC" bundle:nil];
    [camera changeFrame:cameraView.frame];
    [cameraView addSubview:camera.view];
    
    library = [[LibraryCollectionVC alloc] initWithNibName:@"LibraryCollectionVC" bundle:nil];
    [library changeFrame:libraryViewFrame];
    [libraryView addSubview:library.collectionView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
#warning Плохое название для метода return
                                             selector:@selector(return)
                                                 name:@"3 photo ready"
                                               object:nil];
    
#warning не нашел где ты отписываешся от натификейшена, если этого кода нет то ты попадеш в ретейнцикл - и будет память утекать потому что на каждый вызов этого окна в [NSNotificationCenter defaultCenter] addObserver:self будет держать стронг ссылку на объет и не давать его почистить при [self.navigationController popToRootViewControllerAnimated:YES];

    
    
    UIPanGestureRecognizer *swipeUp = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(slideUpWithGestureRecognizer:)];
    [self.gestureView addGestureRecognizer:swipeUp];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)captureImage:(id)sender
{
    captureImageButton.enabled = changeCameraButton.enabled = NO;
    [camera snapImage];
    
#warning зачем такая реализация? 
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [camera newPhoto];
        captureImageButton.enabled = changeCameraButton.enabled = YES;
    });
}

- (IBAction)changeCamera:(id)sender
{
    [camera changeCamera];
}

- (void)return
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Return" object:nil];
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
    self.gestureView.frame = newFrameGesture;
    
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
    self.libraryView.frame = newFrameLibrary;
    
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        gestureViewFrame = self.gestureView.frame;
        libraryViewFrame = self.libraryView.frame;
    }
}

@end
