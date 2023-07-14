//
//  ViewController.m
//  DeprecationTest
//
//  Created by tj on 14.07.23.
//

#import "ViewController.h"
#import <AVKit/AVKit.h>

@interface ViewController () <AVCaptureFileOutputDelegate, AVCaptureFileOutputRecordingDelegate>

@property (nonatomic, strong) AVCaptureSession* captureSession;
@property (nonatomic, strong) AVCaptureScreenInput* captureScreenInput;
@property (nonatomic, strong) AVCaptureMovieFileOutput* captureMovieFileOutput;
@property (nonatomic, assign) CGDirectDisplayID display;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createCaptureSession];
    [self.captureSession startRunning];
    
    NSURL* fileUrl = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/test.mov", NSTemporaryDirectory()]];
    [self.captureMovieFileOutput startRecordingToOutputFileURL:fileUrl recordingDelegate:self];
}


- (BOOL)createCaptureSession {
    if (self.captureSession) {
        [self.captureSession stopRunning];
        self.captureSession = nil;
    }
    
    self.captureSession = [[AVCaptureSession alloc] init];
    
    if ([self.captureSession canSetSessionPreset:AVCaptureSessionPresetHigh]) {
        [self.captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    }
    
    self.display = CGMainDisplayID();
    self.captureScreenInput = [[AVCaptureScreenInput alloc] initWithDisplayID:self.display];
    
    if ([self.captureSession canAddInput:self.captureScreenInput]) {
        [self.captureSession addInput:self.captureScreenInput];
    } else {
        return NO;
    }
        
    self.captureMovieFileOutput = [[AVCaptureMovieFileOutput alloc] init];
    [self.captureMovieFileOutput setDelegate:self];
    
    if ([self.captureSession canAddOutput:self.captureMovieFileOutput]) {
        [self.captureSession addOutput:self.captureMovieFileOutput];
    } else {
        return NO;
    }
        
    return YES;
}

- (void)captureOutput:(AVCaptureFileOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
}

- (BOOL)captureOutputShouldProvideSampleAccurateRecordingStart:(nonnull AVCaptureOutput *)output { 
    return YES;
}


- (BOOL)commitEditingAndReturnError:(NSError *__autoreleasing  _Nullable * _Nullable)error { 
    return YES;
}

- (void)captureOutput:(nonnull AVCaptureFileOutput *)output didFinishRecordingToOutputFileAtURL:(nonnull NSURL *)outputFileURL fromConnections:(nonnull NSArray<AVCaptureConnection *> *)connections error:(nullable NSError *)error { 
    
}

@end
