//
//  GetImageViewController.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "GetImageViewController.h"
#import "CameraViewController.h"
#import "LibraryViewController.h"

@interface GetImageViewController ()

@end

@implementation GetImageViewController

@synthesize libraryView, cameraView, camera, library;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    camera = [[CameraViewController alloc] initWithNibName:@"CameraViewController" bundle:nil];
    library = [[LibraryViewController alloc] initWithNibName:@"LibraryViewController" bundle:nil];
    [cameraView addSubview:camera.view];
    [libraryView addSubview:library.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)captureImage:(id)sender
{
    [camera snapImage];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [camera newPhoto];
    });
}

@end
