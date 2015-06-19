//
//  TWImageLoader.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TWPhoto.h"

@interface TWPhotoLoader : NSObject

@property (strong, nonatomic) NSMutableArray *allPhotos;
@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;

+ (TWPhotoLoader *)sharedLoader;
- (void)startLoading;

@end
