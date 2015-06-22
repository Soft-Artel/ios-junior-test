//
//  LibraryCollectionViewCell.m
//  getPhotos
//
//  Created by test on 17.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "LibraryCollectionViewCell.h"

@implementation LibraryCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.imageView.layer.borderColor = [UIColor blueColor].CGColor;
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    self.imageView.layer.borderWidth = selected ? 2 : 0;
}

@end
