//
//  IBDImageView.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "IBDImageView.h"

@interface IBDImageView ()

@property (nonatomic, strong) EAGLContext *eaglContext;
@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *blurFilter;

@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *blurImage;

@end

@implementation IBDImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _originalImage = self.image;
    }
    return self;
}

- (instancetype)initWithImage:(nullable UIImage *)image {
    self = [super initWithImage:image];
    if (self) {
        _originalImage = image;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image highlightedImage:(nullable UIImage *)highlightedImage {
    self = [super initWithImage:image highlightedImage:highlightedImage];
    if (self) {
        _originalImage = image;
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    if (image != self.blurImage) { //毛玻璃处理
        self.originalImage = image;
        [self updateBlurImage];
    } else {
        [super setImage:image];
    }
}

#pragma mark Blur
- (void)setBlurRadius:(NSInteger)blurRadius {
    if (_blurRadius != blurRadius) {
        NSString *key = NSStringFromSelector(@selector(blurRadius));
        [self willChangeValueForKey:key];
        
        _blurRadius = blurRadius;
        [self updateBlurImage];
        
        [self didChangeValueForKey:key];
    }
}

- (void)updateBlurImage {
    self.blurImage = [self blurImage:self.originalImage withRadius:self.blurRadius];
    
    self.image = self.blurImage;
//    CGImageRef cgImage = self.blurImage.CGImage;
//    
//    self.layer.contents = (__bridge id)cgImage;
}

- (UIImage *)blurImage:(UIImage *)originalImage withRadius:(CGFloat)blurRadius {
    
    CIImage *inputImage = [CIImage imageWithCGImage:[originalImage CGImage]];
    [self.blurFilter setValue:inputImage forKey:kCIInputImageKey];
    [self.blurFilter setValue:@(blurRadius) forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [self.blurFilter outputImage];
    
    CGImageRef cgImage = [self.context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
    UIImage *blurImage       = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return blurImage;
}

#pragma mark - Properties
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

- (CIFilter *)blurFilter {
    if (_blurFilter == nil) {
        _blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
        [_blurFilter setDefaults];
    }
    return _blurFilter;
}

@end
