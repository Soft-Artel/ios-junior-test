//
//  LibraryCollectionViewCell.m
//  getPhotos
//
//  Created by test on 17.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "LibraryCollectionViewCell.h"

@implementation LibraryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.bounds = CGRectMake(0, 0, self.bounds.size.width+50, self.bounds.size.height+50);
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
