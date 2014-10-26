//
//  UIResponder+Appearance.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "UIResponder+Appearance.h"
#import <objc/runtime.h>

@implementation UIResponder (Appearance)

- (void)setApperanceWillChange:(void (^)(id))apperanceWillChange
{
    objc_setAssociatedObject(self, sel_getName(@selector(apperanceWillChange)), apperanceWillChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))apperanceWillChange
{
    return objc_getAssociatedObject(self, sel_getName(@selector(apperanceWillChange)));
}

- (void)setApperanceDidChanged:(void (^)(id))apperanceDidChanged
{
    objc_setAssociatedObject(self, sel_getName(@selector(apperanceDidChanged)), apperanceDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(id))apperanceDidChanged
{
    return objc_getAssociatedObject(self, sel_getName(@selector(apperanceDidChanged)));
}

- (void)setAppearanceState:(unsigned char)appearanceState
{
  objc_setAssociatedObject(self, sel_getName(@selector(appearanceState)), [NSNumber numberWithUnsignedChar:appearanceState], OBJC_ASSOCIATION_ASSIGN);
}

- (unsigned char)appearanceState
{
  return [objc_getAssociatedObject(self, sel_getName(@selector(appearanceState))) unsignedCharValue];
}

- (void)setAppearance:(id)appearance
{
  objc_setAssociatedObject(self, sel_getName(@selector(appearance)), appearance, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)appearance
{
  return objc_getAssociatedObject(self, sel_getName(@selector(appearance)));
}

- (void)setAppearanceConfigKeyPath:(NSString *)appearanceConfigKeyPath
{
  objc_setAssociatedObject(self, sel_getName(@selector(appearanceConfigKeyPath)), appearanceConfigKeyPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)appearanceConfigKeyPath
{
  return objc_getAssociatedObject(self, sel_getName(@selector(appearanceConfigKeyPath)));
}

@end
