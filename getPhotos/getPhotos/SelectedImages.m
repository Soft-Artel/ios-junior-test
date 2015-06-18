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

+ (id)instanceType {
    static id loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[SelectedImages alloc] init];
    });
    return loader;
}

- (instancetype)init
{
    self.selectedImages = [NSMutableArray new];
    return self;
}

@end
