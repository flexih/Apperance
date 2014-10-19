//
//  QNAppearanceConfig.h
//
//  Created by flexih on 10/15/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIResponder+Appearance.h"

@interface AppearanceConfig : NSObject

@property (nonatomic, strong, readonly) NSString *appearance;

- (void)config:(UIResponder *)responder;

@end
