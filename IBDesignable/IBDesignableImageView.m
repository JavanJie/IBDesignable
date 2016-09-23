//
//  IBDesignableImageView.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "IBDesignableImageView.h"
#import <GLKit/GLKit.h>

@interface IBDesignableImageView ()

@property (nonatomic, strong) EAGLContext *eaglContext;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *gaussianBlurFilter;

@property (nonatomic, strong) GLKView *glkView;
@property (nonatomic, assign) CGRect rectInPixels;

@end

@implementation IBDesignableImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        _glkView = [[GLKView alloc] initWithFrame:self.bounds context:eaglContext];
        [_glkView bindDrawable];
        
        [self addSubview:_glkView];
        
        _context = [CIContext contextWithEAGLContext:eaglContext
                                             options:@{kCIContextWorkingColorSpace:[NSNull null]}];
        _rectInPixels = CGRectMake(0.0, 0.0, _glkView.drawableWidth, _glkView.drawableHeight);
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.glkView.bounds = self.bounds;
    
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    
    [self blurImage:image withRadius:self.blurRadius];
}

#pragma mark Blur
- (void)setBlurRadius:(CGFloat)blurRadius {
    NSString *key = NSStringFromSelector(@selector(blurRadius));
    [self willChangeValueForKey:key];
    
    _blurRadius = blurRadius;
    
    [self blurImage:self.image withRadius:blurRadius];
    
//    self.layer.contents = (id)blurImage.CGImage;
    
    [self didChangeValueForKey:key];
}

- (void)blurImage:(UIImage *)originalImage withRadius:(CGFloat)blurRadius {
    
    CIImage *inputImage = [CIImage imageWithCGImage:[originalImage CGImage]];
    [self.gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [self.gaussianBlurFilter setValue:@(blurRadius) forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [self.gaussianBlurFilter outputImage];
    
    _rectInPixels = CGRectMake(0.0, 0.0, _glkView.drawableWidth, _glkView.drawableHeight);
    
    [self.context drawImage:outputImage inRect:self.rectInPixels fromRect:inputImage.extent];
    [self.glkView display];
}


//- (UIImage *)blurImage:(UIImage *)originalImage withRadius:(CGFloat)blurRadius {
//    
//    [self.glkView bindDrawable];
//    
//    CIImage *inputImage = [CIImage imageWithCGImage:[originalImage CGImage]];
//    [self.gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
//    [self.gaussianBlurFilter setValue:@(blurRadius) forKey:kCIInputRadiusKey];
//    
//    CIImage *outputImage = [self.gaussianBlurFilter outputImage];
//    
//    CGRect rectInPixels = CGRectMake(0.0, 0.0, self.glkView.drawableWidth, self.glkView.drawableHeight);
//    [self.context drawImage:outputImage inRect:rectInPixels fromRect:[inputImage extent]];
//    
//    [self.glkView display];
//    
//    CGImageRef cgimg = (__bridge CGImageRef)self.glkView.layer.contents;
//    
////    CGImageRef cgimg     = [self.context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
//    UIImage *blurImage       = [UIImage imageWithCGImage:cgimg];
//    CGImageRelease(cgimg);
//    
//    return blurImage;
//}

- (EAGLContext *)eaglContext {
    if (_eaglContext == nil) {
        _eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    }
    return _eaglContext;
}

- (CIContext *)context {
    if (_context == nil) {
        _context   = [CIContext contextWithEAGLContext:self.eaglContext options:@{kCIContextUseSoftwareRenderer : @(NO)}];
    }
    return _context;
}

- (CIFilter *)gaussianBlurFilter {
    if (_gaussianBlurFilter == nil) {
        _gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [_gaussianBlurFilter setDefaults];
    }
    return _gaussianBlurFilter;
}

- (GLKView *)glkView {
    if (_glkView == nil) {
        _glkView = [[GLKView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) context:self.eaglContext];
    }
    return _glkView;
}

@end
