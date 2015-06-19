//
//  SelectedImages.m
//  getPhotos
//
//  Created by test on 18.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "SelectedImages.h"

@implementation SelectedImages

@synthesize selectedImages;

+ (SelectedImages *)sharedInstance
{
    static SelectedImages *shared;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[SelectedImages alloc] init];
    });
    return shared;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.selectedImages = [NSMutableArray new];
    }
    return self;
}

- (void)saveImage:(UIImage *)image
{
    SelectedImages *images = [SelectedImages sharedInstance];
    [images.selectedImages addObject:image];
    if ([images.selectedImages count] == 4) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"4 photo ready" object:nil];
    }
}

@end
