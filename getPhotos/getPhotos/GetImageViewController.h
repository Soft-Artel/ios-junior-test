//
//  GetImageViewController.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CameraViewController.h"
#import "LibraryViewController.h"

@interface GetImageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) IBOutlet UIView *libraryView;
@property CameraViewController *camera;
@property LibraryViewController *library;

@end
