//
//  SelectedImagesCell.m
//  getPhotos
//
//  Created by test on 19.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "SelectedImagesCell.h"

@implementation SelectedImagesCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

@end
