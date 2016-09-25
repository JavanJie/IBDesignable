//
//  IBDImageView.h
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+IBDesignable.h"

@interface IBDImageView : UIImageView

@property(nonatomic, assign) IBInspectable NSInteger blurRadius; /* 毛玻璃半径 */

@property (nonatomic, readonly) UIImage *blurImage;

@end
