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

+ (instancetype)configWithPath:(NSString *)path;

- (instancetype)initWithPath:(NSString *)path;
- (instancetype)initWithData:(NSData *)jsonData;
- (instancetype)initWithString:(NSString *)string;

- (void)configResponder:(UIResponder *)responder;

@end
