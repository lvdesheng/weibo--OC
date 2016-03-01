//
//  UIView+xib.h
//  BSBDJ
//
//  Created by lvdesheng on 16/2/21.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (xib)
// 从xib加载view
+ (instancetype)viewForXib;
@end
