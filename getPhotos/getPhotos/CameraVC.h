//
//  CameraViewController.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CameraVC : UIViewController

@property (strong, nonatomic) IBOutlet UIView *imagePreview;
@property (strong, nonatomic) IBOutlet UIImageView *captureImage;

- (void)snapImage;
- (void)newPhoto;
- (void)changeCamera;
- (void)changeFrame:(CGRect)frame;

@end
