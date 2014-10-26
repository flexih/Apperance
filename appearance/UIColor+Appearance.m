//
//  UIColor+Appearance.m
//
//  Created by flexih on 10/24/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "UIColor+Appearance.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255. green:(g)/255. blue:(b)/255. alpha:(a)]

@implementation UIColor (Appearance)

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

+ (instancetype)colorWithObject:(id)object
{
  NSAssert([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]], @"%s not support %@", sel_getName(_cmd), object);
  
  if ([object isKindOfClass:[NSString class]]) {
    if ([(NSString *)object rangeOfString:@","].length == 0) {
      SEL classSelector = NSSelectorFromString(object);
      NSAssert([self respondsToSelector:classSelector], @"%s not support %@", sel_getName(_cmd), object);
      return [self performSelector:classSelector];
    }
    
    NSArray *rgba = [(NSString *)object componentsSeparatedByString:@","];
    
    NSAssert(rgba.count >= 3, @"%s components count %zu", sel_getName(_cmd), rgba.count);
    
    int r = [rgba[0] intValue];
    int g = [rgba[1] intValue];
    int b = [rgba[2] intValue];
    
    float a = 1;
    
    if (rgba.count > 3) {
      a = [rgba[3] floatValue];
    }
    
    return RGBA(r, g, b, a);
  } else if ([object isKindOfClass:[NSNumber class]]) {
    unsigned int hex = [object intValue];
    return RGBA(hex >> 16 & 0xff, hex >> 8 & 0xff, hex & 0xff, 1);
  }
  
  return nil;
}

#pragma clang diagnostic pop

@end
