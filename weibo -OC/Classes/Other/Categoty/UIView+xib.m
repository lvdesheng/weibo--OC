//
//  UIView+xib.m
//  BSBDJ
//
//  Created by lvdesheng on 16/2/21.
//  Copyright © 2016年 lvdesheng. All rights reserved.
//

#import "UIView+xib.h"

@implementation UIView (xib)

+ (instancetype)viewForXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil][0];
}

@end
