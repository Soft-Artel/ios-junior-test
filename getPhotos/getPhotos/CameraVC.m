//
//  CameraViewController.m
//  getPhotos
//
//  Created by test on 16.06.15.
//  Copyright (c) 2015 test. All rights reserved.
//

#import "CameraVC.h"
#import <AVFoundation/AVFoundation.h>
#import "SelectedImages.h"

@interface CameraVC ()

@end

@implementation CameraVC
{
    AVCaptureSession *session;
    AVCaptureDevice *camera;
    AVCaptureDeviceInput *input;
    AVCaptureStillImageOutput *stillImageOutput;
    UIImage *lastPhoto;
}

@synthesize captureImage, imagePreview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initCamera];
}

- (void)initCamera
{
    session = [AVCaptureSession new];
    session.sessionPreset = AVCaptureSessionPresetPhoto;
    AVCaptureVideoPreviewLayer *captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:session];
    [captureVideoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    captureVideoPreviewLayer.frame = self.imagePreview.bounds;
    [self.imagePreview.layer addSublayer:captureVideoPreviewLayer];
    
    UIView *view = self.imagePreview;
    CALayer *viewLayer = [view layer];
    [viewLayer setMasksToBounds:YES];
    CGRect bounds = [self.imagePreview bounds];
    [captureVideoPreviewLayer setFrame:bounds];
    
    camera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    input = [AVCaptureDeviceInput deviceInputWithDevice:camera error:nil];
    [session addInput:input];
    stillImageOutput = [AVCaptureStillImageOutput new];
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    [stillImageOutput setOutputSettings:outputSettings];
    [session addOutput:stillImageOutput];
    [session startRunning];
}

- (void)changeCamera
{
    AVCaptureDevicePosition reversePosition;
    if ([input.device position] == AVCaptureDevicePositionFront) {
        reversePosition = AVCaptureDevicePositionBack;
    } else {
        reversePosition = AVCaptureDevicePositionFront;
    }
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    AVCaptureDevice *reverseDevice = nil;
    for (AVCaptureDevice *device in devices) {
        if ([device position] == reversePosition) {
            reverseDevice = device;
            break;
        }
    }
    [session removeInput:input];
    input = [AVCaptureDeviceInput deviceInputWithDevice:reverseDevice error:nil];
    [session addInput:input];
}

- (void)snapImage
{
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in stillImageOutput.connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    [stillImageOutput captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
        if (imageSampleBuffer != NULL) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
            [self processImage:[UIImage imageWithData:imageData]];
        }
    }];
}

- (void)processImage:(UIImage *)image
{
    if ([UIDevice currentDevice].userInterfaceIdiom==UIUserInterfaceIdiomPhone) {
        UIGraphicsBeginImageContext(CGSizeMake(image.size.width, image.size.height));
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        CGRect cropRect = CGRectMake(0, 0, image.size.width, image.size.width);
        CGImageRef imageRef = CGImageCreateWithImageInRect([smallImage CGImage], cropRect);
        lastPhoto = [UIImage imageWithCGImage:imageRef];
        [self.captureImage setImage:lastPhoto];
        UIImageWriteToSavedPhotosAlbum(lastPhoto, nil, nil, nil);
        [[SelectedImages sharedInstance] saveImage:lastPhoto];
        CGImageRelease(imageRef);
        self.captureImage.hidden = NO;
        self.imagePreview.hidden = YES;
    }
}

- (void)newPhoto
{
    imagePreview.hidden = NO;
    captureImage.hidden = YES;
}

- (void)changeFrame:(CGRect)frame
{
    self.view.frame = frame;
}

@end
