//
//  ViewController.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "GetImageVC.h"
#import "SelectedImages.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView1;
@property (strong, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *imageView3;
@property (strong, nonatomic) IBOutlet UIButton *startButton;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(setImages)
                                                 name:@"Return"
                                               object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender
{
    GetImageVC *getImageVC = [[GetImageVC alloc] initWithNibName:@"GetImageVC" bundle:nil];
    [self.navigationController pushViewController:getImageVC animated:YES];
}

- (void)setImages
{
    SelectedImages *images = [SelectedImages instanceType];
    self.imageView1.image = [images.selectedImages objectAtIndex:0];
    self.imageView2.image = [images.selectedImages objectAtIndex:1];
    self.imageView3.image = [images.selectedImages objectAtIndex:2];
    self.startButton.hidden = YES;
}

@end
