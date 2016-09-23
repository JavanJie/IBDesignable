//
//  IBDesignableImageView.h
//  IBDesignable
//
//  Created by 陈杰 on 16/9/23.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+IBDesignable.h"
#import "UIImageView+IBDesignable.h"

@interface IBDesignableImageView : UIImageView

@property(nonatomic, assign) IBInspectable CGFloat blurRadius; /* 毛玻璃半径 */

@end
