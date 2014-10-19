//
//  UIResponder+Appearance.h
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, AppearanceState) {
  kAppearanceStateWantsUpdate = 1,
  kAppearanceStateWantsUpdateAlways
};

@interface UIResponder (Appearance)

@property (nonatomic, strong, readonly) id appearance;
@property (nonatomic, readonly) unsigned char appearanceState;
@property (nonatomic, strong) NSString *appearanceConfigKeyPath;
@property (nonatomic, copy) BOOL (^apperanceWillChange)(id newAppearanceKey);
@property (nonatomic, copy) void (^apperanceDidChanged)(id oldAppearanceKey);

@end
