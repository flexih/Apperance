//
//  UIResponder+Appearance.h
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Appearance)

@property (nonatomic, strong, readonly) id apperanceKey;
@property (nonatomic, copy) BOOL (^apperanceWillChange)(id newAppearanceKey);
@property (nonatomic, copy) void (^apperanceDidChanged)(void);
@property (nonatomic) BOOL appearanceWantsUpdateAlways;

@end
