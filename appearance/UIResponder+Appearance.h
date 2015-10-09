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

@property (nonatomic, strong) NSString *appearanceConfigKeyPath;
@property (nonatomic, copy) void (^apperanceWillChange)(id newAppearanceKey);
@property (nonatomic, copy) void (^apperanceDidChanged)(id oldAppearanceKey);
@property (nonatomic, readonly) unsigned char appearanceState;
@property (nonatomic, strong, readonly) NSString *appearance;

@end
