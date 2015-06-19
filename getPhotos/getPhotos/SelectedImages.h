//
//  SelectedImages.h
//  getPhotos
//
//  Created by test on 18.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectedImages : NSObject

@property (strong, nonatomic) NSMutableArray *selectedImages;

+ (SelectedImages *)sharedInstance;
- (void)saveImage:(UIImage *)image;

@end
