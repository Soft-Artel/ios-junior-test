//
//  TWPhoto.h
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface TWPhoto : NSObject

@property (nonatomic, readonly) UIImage *thumbnailImage;
@property (nonatomic, readonly) UIImage *originalImage;
@property (nonatomic, strong) ALAsset *asset;

@end
