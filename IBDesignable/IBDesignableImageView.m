//
//  IBDesignableImageView.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "IBDesignableImageView.h"

@interface IBDesignableImageView ()

@property (nonatomic, strong) CIContext *context;
@property (nonatomic, strong) CIFilter *gaussianBlurFilter;

@end

@implementation IBDesignableImageView

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    
    [self blurImage:image withRadius:self.blurRadius];
}

#pragma mark Blur
- (void)setBlurRadius:(CGFloat)blurRadius {
    NSString *key = NSStringFromSelector(@selector(blurRadius));
    [self willChangeValueForKey:key];
    
    _blurRadius = blurRadius;
    
    UIImage *blurImage = [self blurImage:self.image withRadius:blurRadius];
    
    self.layer.contents = (id)blurImage.CGImage;
    
    [self didChangeValueForKey:key];
}

- (UIImage *)blurImage:(UIImage *)originalImage withRadius:(CGFloat)blurRadius {
    CIImage *inputImage = [CIImage imageWithCGImage:[originalImage CGImage]];
    [self.gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
    [self.gaussianBlurFilter setValue:@(blurRadius) forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [self.gaussianBlurFilter outputImage];
    
    CGImageRef cgimg     = [self.context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
    UIImage *blurImage       = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    return blurImage;
}

- (CIContext *)context {
    if (_context == nil) {
        EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        _context   = [CIContext contextWithEAGLContext:eaglContext options:@{kCIContextUseSoftwareRenderer : @(NO)}];
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

@end
