//
//  UIView+IBDesignable.h
//  IBDesignable
//
//  Created by 陈杰 on 16/9/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIView (IBDesignable)

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property(nonatomic, assign) IBInspectable BOOL semicircle; /* 左右保持半圆 */

@property(nonatomic, strong) IBInspectable UIColor *borderColor;
@property(nonatomic, assign) IBInspectable CGFloat borderWidth;

@property(nonatomic, assign) IBInspectable CGFloat rotation; /* -360~360  */

@property(nonatomic, assign) IBInspectable UIColor *shadowColor;
@property(nonatomic, assign) IBInspectable CGFloat shadowRadius;
@property(nonatomic, assign) IBInspectable CGFloat shadowOpacity;
@property(nonatomic, assign) IBInspectable CGPoint shadowOffset;

@property(nonatomic, assign) IBInspectable CGPoint gradientStartPoint;  /* 0~1 */
@property(nonatomic, assign) IBInspectable CGPoint gradientEndPoint;    /* 0~1 */
@property(nonatomic, strong) IBInspectable UIColor *gradientStartColor;
@property(nonatomic, strong) IBInspectable UIColor *gradientEndColor;



@end
