//
//  ViewController.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "GetImageViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)buttonPressed:(id)sender
{
    GetImageViewController *getImageVC = [[GetImageViewController alloc] initWithNibName:@"GetImageViewController" bundle:nil];
    [self.navigationController pushViewController:getImageVC animated:YES];
}

@end
