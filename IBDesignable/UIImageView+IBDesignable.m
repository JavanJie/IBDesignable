//
//  UIImageView+IBDesignable.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIImageView+IBDesignable.h"
#import <objc/runtime.h>

@implementation UIImageView (IBDesignable)

//#pragma mark Blur
//- (void)setBlurRadius:(CGFloat)blurRadius {
//    objc_setAssociatedObject(self, @selector(blurRadius), @(blurRadius), OBJC_ASSOCIATION_ASSIGN);
//    
//    UIImage *originalImage = [self image];
//    UIImage *blurImage = [self blurImage:originalImage withRadius:blurRadius];
//    
//    self.layer.contents = (id)blurImage.CGImage;
//}
//
//- (UIImage *)blurImage:(UIImage *)originalImage withRadius:(CGFloat)blurRadius {
//    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"]; //kCICategoryBlur
//    [gaussianBlurFilter setDefaults];
//    CIImage *inputImage = [CIImage imageWithCGImage:[originalImage CGImage]];
//    [gaussianBlurFilter setValue:inputImage forKey:kCIInputImageKey];
//    [gaussianBlurFilter setValue:@(blurRadius) forKey:kCIInputRadiusKey];
//    
//    CIImage *outputImage = [gaussianBlurFilter outputImage];
////    CIContext *context   = [CIContext contextWithOptions:nil];
////    EAGLContext *eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
//    EAGLContext *eaglContext = [self openEAGLContext];
//    CIContext *context   = [CIContext contextWithEAGLContext:eaglContext options:nil];
//    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:[inputImage extent]];  // note, use input image extent if you want it the same size, the output image extent is larger
//    UIImage *blurImage       = [UIImage imageWithCGImage:cgimg];
//    CGImageRelease(cgimg);
//    
//    return blurImage;
//}
//
//- (CGFloat)blurRadius {
//    NSNumber *blurRadiusNumber = objc_getAssociatedObject(self, _cmd);
//    return [blurRadiusNumber floatValue];
//}
//
//- (EAGLContext *)openEAGLContext {
//    SEL sel = @selector(eaglContext);
//    EAGLContext *eaglContext = objc_getAssociatedObject(self, sel);
//    if (eaglContext == nil) {
//        @synchronized (self) {
//            if (eaglContext == nil) {
//                eaglContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
//                
//                objc_setAssociatedObject(self, sel, eaglContext, OBJC_ASSOCIATION_ASSIGN);
//            }
//        }
//    }
//    return eaglContext;
//}

@end
