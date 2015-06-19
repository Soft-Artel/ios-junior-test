//
//  ImageVC.h
//  getPhotos
//
//  Created by test on 19.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageVC : UIViewController

@property (strong, nonatomic) UIImageView *imgView;

- (id)initWithImage:(UIImage *)image;

@end
