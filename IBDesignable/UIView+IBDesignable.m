//
//  UIView+IBDesignable.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "UIView+IBDesignable.h"
#import <objc/runtime.h>

@implementation UIView (IBDesignable)

#pragma mark - CornerRadius
- (void)setCornerRadius:(CGFloat)cornerRadius {
    objc_setAssociatedObject(self, @selector(cornerRadius), @(cornerRadius), OBJC_ASSOCIATION_ASSIGN);
    self.layer.cornerRadius = cornerRadius;
    self.gradientLayer.cornerRadius = cornerRadius;
}

- (CGFloat)cornerRadius {
    NSNumber *cornerRadiusNumber = objc_getAssociatedObject(self, _cmd);
    return [cornerRadiusNumber floatValue];
}

- (void)setSemicircle:(BOOL)semicircle {
    objc_setAssociatedObject(self, @selector(semicircle), @(semicircle), OBJC_ASSOCIATION_ASSIGN);
    
    SEL propertyName = @selector(originalSemicircle);
    if (semicircle) {
        objc_setAssociatedObject(self, propertyName, @(self.layer.cornerRadius), OBJC_ASSOCIATION_ASSIGN);
        CGFloat cornerRadius = CGRectGetHeight(self.bounds) / 2.0f;
        self.cornerRadius = cornerRadius;
        self.gradientLayer.cornerRadius = cornerRadius;
    } else {
        NSNumber *originalCornerRadiusNumber = objc_getAssociatedObject(self, propertyName);
        CGFloat cornerRadius = [originalCornerRadiusNumber floatValue];
        self.cornerRadius = cornerRadius;
        self.gradientLayer.cornerRadius = cornerRadius;
    }
}

- (BOOL)semicircle {
    NSNumber *semicircleNumber = objc_getAssociatedObject(self, _cmd);
    return [semicircleNumber boolValue];
}

#pragma mark - Border
- (void)setBorderColor:(UIColor *)color {
    objc_setAssociatedObject(self, @selector(borderColor), color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.borderColor = color.CGColor;
}

- (UIColor *)borderColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    return color;
}

- (void)setBorderWidth:(CGFloat)width {
    objc_setAssociatedObject(self, @selector(borderWidth), @(width), OBJC_ASSOCIATION_ASSIGN);
    self.layer.borderWidth = width;
}

- (CGFloat)borderWidth {
    NSNumber *widthNumber = objc_getAssociatedObject(self, _cmd);
    return [widthNumber floatValue];
}


#pragma mark Rotation
#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)
- (void)setRotation:(CGFloat)rotation {
    objc_setAssociatedObject(self, @selector(rotation), @(rotation), OBJC_ASSOCIATION_ASSIGN);
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(rotation));
}

- (CGFloat)rotation {
    NSNumber *rotationNumber = objc_getAssociatedObject(self, _cmd);
    return [rotationNumber floatValue];
}

#pragma mark - Shadown
- (void)setShadowColor:(UIColor *)shadowColor {
    objc_setAssociatedObject(self, @selector(shadowColor), shadowColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor {
    UIColor *color = objc_getAssociatedObject(self, _cmd);
    return color;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    objc_setAssociatedObject(self, @selector(shadowRadius), @(shadowRadius), OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    NSNumber *shadowRadiusNumber = objc_getAssociatedObject(self, _cmd);
    return [shadowRadiusNumber floatValue];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    objc_setAssociatedObject(self, @selector(shadowOpacity), @(shadowOpacity), OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity {
    NSNumber *shadowOpacityNumber = objc_getAssociatedObject(self, _cmd);
    return [shadowOpacityNumber floatValue];
}

- (void)setShadowOffset:(CGPoint)shadowOffset {
    objc_setAssociatedObject(self, @selector(shadowOffset), [NSValue valueWithCGPoint:shadowOffset], OBJC_ASSOCIATION_ASSIGN);
    self.layer.shadowOffset = CGSizeMake(shadowOffset.x, -shadowOffset.y);
}

- (CGPoint)shadowOffset {
    NSValue *shadowOffsetValue = objc_getAssociatedObject(self, _cmd);
    return [shadowOffsetValue CGPointValue];
}

#pragma mark - Gradient
- (void)configureGradient {
    CAGradientLayer *gradientLayer = [self gradientLayer];
    
    CGPoint nullPoint;
    if (self.gradientStartColor == nil || self.gradientEndColor == nil || CGPointEqualToPoint(self.gradientStartPoint, nullPoint)  || CGPointEqualToPoint(self.gradientEndPoint, nullPoint)) {
        [gradientLayer removeFromSuperlayer];
    } else {
        gradientLayer.colors = @[(id)self.gradientStartColor.CGColor, (id)self.gradientEndColor.CGColor];
        
        gradientLayer.startPoint = self.gradientStartPoint;
        gradientLayer.endPoint = self.gradientEndPoint;
        
        gradientLayer.frame = self.bounds;
        gradientLayer.cornerRadius = self.cornerRadius;
        
        //        [self.layer addSublayer:gradientLayer];
        [self.layer insertSublayer:gradientLayer atIndex:0];
    }
}

- (void)configureGradientColors {
    CAGradientLayer *gradientLayer = [self gradientLayer];
    
    NSMutableArray *colors = [NSMutableArray arrayWithCapacity:2];
    if (self.gradientStartColor) {
        [colors addObject:(id)self.gradientStartColor.CGColor];
    }
    if (self.gradientEndColor) {
        [colors addObject:(id)self.gradientEndColor.CGColor];
    }
    gradientLayer.colors = colors;
}

- (CAGradientLayer *)gradientLayer {
    CAGradientLayer *gradientLayer = objc_getAssociatedObject(self, _cmd);
    if ([gradientLayer isKindOfClass:[CAGradientLayer class]] == NO) {
        gradientLayer = [[CAGradientLayer alloc]init];
        gradientLayer.frame = self.bounds;
        gradientLayer.cornerRadius = self.layer.cornerRadius;
        
//        [self.layer addSublayer:gradientLayer];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
        objc_setAssociatedObject(self, _cmd, gradientLayer, OBJC_ASSOCIATION_ASSIGN);
    }
    return gradientLayer;
}

- (void)setGradientStartColor:(UIColor *)gradientStartColor {
    objc_setAssociatedObject(self, @selector(gradientStartColor), gradientStartColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configureGradientColors];
}

- (UIColor *)gradientStartColor {
    UIColor *gradientStartColor = objc_getAssociatedObject(self, _cmd);
    return gradientStartColor;
}

- (void)setGradientEndColor:(UIColor *)gradientEndColor {
    objc_setAssociatedObject(self, @selector(gradientEndColor), gradientEndColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self configureGradientColors];
}

- (UIColor *)gradientEndColor {
    UIColor *gradientEndColor = objc_getAssociatedObject(self, _cmd);
    return gradientEndColor;
}

- (void)setGradientStartPoint:(CGPoint)gradientStartPoint {
    objc_setAssociatedObject(self, @selector(gradientStartPoint), [NSValue valueWithCGPoint:gradientStartPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    CAGradientLayer *gradientLayer = [self gradientLayer];
    gradientLayer.startPoint = gradientStartPoint;
//    [self configureGradient];
}

- (CGPoint)gradientStartPoint {
    NSValue *gradientStartPointValue = objc_getAssociatedObject(self, _cmd);
    return [gradientStartPointValue CGPointValue];
}

- (void)setGradientEndPoint:(CGPoint)gradientEndPoint {
    objc_setAssociatedObject(self, @selector(gradientEndPoint), [NSValue valueWithCGPoint:gradientEndPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    CAGradientLayer *gradientLayer = [self gradientLayer];
    gradientLayer.endPoint = gradientEndPoint;
//    [self configureGradient];
}

- (CGPoint)gradientEndPoint {
    NSValue *gradientEndPointValue = objc_getAssociatedObject(self, _cmd);
    return [gradientEndPointValue CGPointValue];
}

@end
