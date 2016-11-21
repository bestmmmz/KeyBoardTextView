//
//  Color.h
//
//  Created by mac on 16/7/8.
//  Copyright © 2016年 Laomeng. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  16进制颜色(字符串)
 */
@interface Color : NSObject

+ (UIColor *)colorWithHex:(NSString *)color;

@end
