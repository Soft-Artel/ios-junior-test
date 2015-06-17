//
//  CameraViewController.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface CameraViewController : UIViewController

@property(nonatomic, retain) AVCaptureStillImageOutput *stillImageOutput;
@property (strong, nonatomic) IBOutlet UIView *imagePreview;
@property (strong, nonatomic) IBOutlet UIImageView *captureImage;

- (void)snapImage;
- (void)newPhoto;

@end
