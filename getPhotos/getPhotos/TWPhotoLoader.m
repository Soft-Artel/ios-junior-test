//
//  TWImageLoader.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "TWPhotoLoader.h"

@interface TWPhotoLoader ()

@end

@implementation TWPhotoLoader

@synthesize allPhotos, assetsLibrary;

+ (TWPhotoLoader *)sharedLoader
{
    static TWPhotoLoader *loader;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loader = [[TWPhotoLoader alloc] init];
    });
    return loader;
}

- (void)startLoading
{
    ALAssetsGroupEnumerationResultsBlock assetsEnumerationBlock = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            TWPhoto *photo = [TWPhoto new];
            photo.asset = result;
            [self.allPhotos insertObject:photo atIndex:0];
        }
    };
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        ALAssetsFilter *onlyPhotosFilter = [ALAssetsFilter allPhotos];
        [group setAssetsFilter:onlyPhotosFilter];
        if ([group numberOfAssets] > 0) {
            if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue] == ALAssetsGroupSavedPhotos) {
                [group enumerateAssetsUsingBlock:assetsEnumerationBlock];
            }
        }
        if (group == nil) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Objects ready" object:nil];
        }
    };
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:listGroupBlock failureBlock:^(NSError *error) {}];
}

- (ALAssetsLibrary *)assetsLibrary
{
    if (assetsLibrary == nil) {
        assetsLibrary = [[ALAssetsLibrary alloc] init];
    }
    return assetsLibrary;
}

- (NSMutableArray *)allPhotos
{
    if (allPhotos == nil) {
        allPhotos = [NSMutableArray array];
    }
    return allPhotos;
}

@end
