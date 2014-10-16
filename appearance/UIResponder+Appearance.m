//
//  UIResponder+Appearance.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "UIResponder+Appearance.h"
#import <objc/runtime.h>

@implementation UIResponder (Appearance)

- (void)setApperanceWillChange:(BOOL (^)(id))apperanceWillChange
{
    objc_setAssociatedObject(self, sel_getName(@selector(apperanceWillChange)), apperanceWillChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL (^)(id))apperanceWillChange
{
    return objc_getAssociatedObject(self, sel_getName(@selector(apperanceWillChange)));
}

- (void)setApperanceDidChanged:(void (^)(void))apperanceDidChanged
{
    objc_setAssociatedObject(self, sel_getName(@selector(apperanceDidChanged)), apperanceDidChanged, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(void))apperanceDidChanged
{
    return objc_getAssociatedObject(self, sel_getName(@selector(apperanceDidChanged)));
}

- (void)setAppearanceWantsUpdateAlways:(BOOL)appearanceWantsUpdateAlways
{
  objc_setAssociatedObject(self, sel_getName(@selector(appearanceWantsUpdateAlways)), [NSNumber numberWithBool:appearanceWantsUpdateAlways], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)appearanceWantsUpdateAlways
{
  return [objc_getAssociatedObject(self, sel_getName(@selector(appearanceWantsUpdateAlways))) boolValue];
}

- (void)setApperanceKey:(id)apperanceKey
{
  objc_setAssociatedObject(self, sel_getName(@selector(apperanceKey)), apperanceKey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)apperanceKey
{
  return objc_getAssociatedObject(self, sel_getName(@selector(apperanceKey)));
}

@end
