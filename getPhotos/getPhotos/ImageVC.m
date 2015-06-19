//
//  ImageVC.m
//  getPhotos
//
//  Created by test on 19.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "ImageVC.h"

@interface ImageVC ()

@end

@implementation ImageVC

@synthesize imgView;

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        imgView = [[UIImageView alloc] initWithImage:image];
        [self changeImageSize:image];
        [self.view addSubview:imgView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)changeImageSize:(UIImage *)image
{
    CGFloat width = self.view.frame.size.width/image.size.width;
    CGFloat height = 1;
    CGFloat originX = 0;
    CGFloat originY = 0;
    if (image.size.height * width + 64 >= self.view.frame.size.height) {
        height *= (self.view.frame.size.height - 64)/(image.size.height*width);
        originX = (self.view.frame.size.width - image.size.width * width * height) / 2;
    } else {
        originY = (self.view.frame.size.height - 64 - image.size.height * width) / 2;
    }
    imgView.frame = CGRectMake(originX, originY + 64, image.size.width * width * height, image.size.height * width * height);
}

@end
