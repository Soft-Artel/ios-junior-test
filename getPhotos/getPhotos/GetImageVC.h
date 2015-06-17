//
//  GetImageViewController.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetImageVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *cameraView;
@property (strong, nonatomic) IBOutlet UIView *libraryView;
@property (strong, nonatomic) IBOutlet UIButton *captureImageButton;
@property (strong, nonatomic) IBOutlet UIButton *changeCameraButton;

@end
