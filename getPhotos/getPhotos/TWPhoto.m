//
//  TWPhoto.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "TWPhoto.h"

@implementation TWPhoto

- (UIImage *)thumbnailImage
{
    return [UIImage imageWithCGImage:self.asset.thumbnail];
}

- (UIImage *)originalImage
{
    return [UIImage imageWithCGImage:self.asset.defaultRepresentation.fullResolutionImage
                               scale:self.asset.defaultRepresentation.scale
                         orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
}

@end
