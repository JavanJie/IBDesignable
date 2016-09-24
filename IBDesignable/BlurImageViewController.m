//
//  BlurImageViewController.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/24.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "BlurImageViewController.h"
#import <GLKit/GLKit.h>

@interface BlurImageViewController ()

@property (nonatomic, strong) UIImage *blurImage;
@property(nonatomic, assign) CGFloat blurRadius; /* 毛玻璃半径 */

@property (weak, nonatomic) IBOutlet GLKView *glView;

@property (nonatomic, strong) EAGLContext *eaglContext;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *gaussianBlurFilter;

@end

@implementation BlurImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    self.context = [CIContext contextWithEAGLContext:self.eaglContext options:@{
//                                                                                kCIContextWorkingColorSpace : [NSNull null]
//                                                                                , kCIContextUseSoftwareRenderer : @(NO)
                                                                                }];
    
    self.gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [self.gaussianBlurFilter setDefaults];
    
    self.glView.context = self.eaglContext;
    self.glView.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    [self.glView bindDrawable];
    
    BOOL successed = [EAGLContext setCurrentContext:self.eaglContext];
    
    [self displayImage:self.image withBlurRadius:self.blurRadius];
}

- (void)setImage:(UIImage *)image {
    NSString *key = NSStringFromSelector(@selector(image));
    
    [self willChangeValueForKey:key];
    
    _image = image;
    
    if (self.viewLoaded) {
        [self displayImage:image withBlurRadius:self.blurRadius];
    }
    
    [self didChangeValueForKey:key];
}

#pragma mark Blur
- (void)setBlurRadius:(CGFloat)blurRadius {
    NSString *key = NSStringFromSelector(@selector(blurRadius));
    [self willChangeValueForKey:key];
    
    _blurRadius = blurRadius;
    
    [self displayImage:self.image withBlurRadius:blurRadius];
    
    [self didChangeValueForKey:key];
}

- (void)displayImage:(UIImage *)image withBlurRadius:(CGFloat)radius {
    CIImage *inputImage = [CIImage imageWithCGImage:[image CGImage]];

    [self.gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [self.gaussianBlurFilter setValue:@(radius) forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [self.gaussianBlurFilter outputImage];
    
    CGRect rectInPixels = CGRectMake(0.0, 0.0, self.glView.drawableWidth, self.glView.drawableHeight);
//
    [self.context drawImage:outputImage inRect:rectInPixels fromRect:inputImage.extent];
    
//    [self drawCIImage:outputImage];
    
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    [self.glView display];
}

- (void)drawCIImage:(CIImage *)image
{
    CGRect rect = [image extent];
    
    // http://stackoverflow.com/questions/8778117/video-filtering-in-iphone-is-slow
    
    GLuint _renderBuffer;
    CGContextRef cgContext;
    CIContext *coreImageContext;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * rect.size.width;
    NSUInteger bitsPerComponent = 8;
    cgContext = CGBitmapContextCreate(NULL, rect.size.width, rect.size.height, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast);
    CGColorSpaceRelease(colorSpace);
    
    
//    EAGLContext *glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    EAGLContext *glContext = self.eaglContext;
    
    coreImageContext = [CIContext contextWithEAGLContext:glContext];
    
    glGenRenderbuffers(1, &_renderBuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, _renderBuffer);
    
    [EAGLContext setCurrentContext:glContext];
    [coreImageContext drawImage:image inRect:CGRectMake(0, 0, 100, 100) fromRect:rect];
}

- (IBAction)blurValueChanged:(UISlider *)sender {
    [self displayImage:self.image withBlurRadius:sender.value];
}


@end
