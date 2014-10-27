//
//  UIImage+Appearance.m
//
//  Created by flexih on 10/24/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "UIImage+Appearance.h"

@implementation UIImage (Appearance)

+ (instancetype)imageWithText:(NSString *)text
{
  //name
  //file://path
  //file://path/[bundle]/path
  //http://
  //bundle://[bundle]/path
  
  NSRange range = [text rangeOfString:@"://" options:0 range:NSMakeRange(0, MIN(text.length, 9))];
  
  if (range.length == 0) {
    return [UIImage imageNamed:text];
  }
  
  NSString *path = NSHomeDirectory();
  
  BOOL isFile = [text hasPrefix:@"file"];
  BOOL isBundle = !isFile;
  
  if (isBundle) {
    isBundle = [text hasPrefix:@"bundle"];
  }
  
  if (isFile || isBundle) {
    return [self imageWithBundlePath:[text substringFromIndex:NSMaxRange(range)]
                          rootBundle:isBundle ? [NSBundle mainBundle] : nil
                            rootPath:isFile ? path : nil];
  }
  
  if ([text hasPrefix:@"http"]) {
    NSAssert(0, @"code goes here");
  }
  
  NSAssert(0, @"%s not support %@", sel_getName(_cmd), text);
  
  return nil;
}

+ (UIImage *)imageWithBundlePath:(NSString *)path rootBundle:(NSBundle *)rootBundle rootPath:(NSString *)rootPath
{
  NSBundle *bundle = rootBundle;
  NSString *bundleName = nil;
  NSUInteger pos = 0, poss = 0;
  int state = 0;
  
  for (NSUInteger i = 0; i < path.length; i++) {
    unichar ch = [path characterAtIndex:i];
    if (ch == (unichar)'[') {
      if (state == 0) {
        state = '[';
        pos = i;
        continue;
      }
      assert("error");
    }
    
    if (ch == (unichar)']') {
      if (state == '[') {
        state = ']';
      }
      assert("error");
    }
    
    if (state == ']') {
      NSRange range;
      range.location = poss < pos ? poss: 0;
      range.length = pos - range.location;
      
      bundleName = [path substringWithRange:NSMakeRange(pos + 1, i - pos - 1)];
      
      NSString *bundlePath = [[path substringWithRange:range] stringByAppendingPathComponent:bundleName];
      
      if (bundle == nil) {
        bundle = [NSBundle bundleWithPath:[rootPath stringByAppendingPathComponent:bundlePath]];
      } else {
        bundle = [NSBundle bundleWithPath:[bundle pathForResource:bundlePath ofType:nil]];
      }
      
      state = 0;
      poss = i + 1;
    }
  }
  
  NSString *filePath;
  
  if (bundle == nil) {
    filePath = [rootPath stringByAppendingPathComponent:path];
  } else {
    filePath = [bundle pathForResource:[path substringFromIndex:pos + 1 + bundleName.length + 1 + 1] ofType:nil];
  }
  
  return [UIImage imageWithContentsOfFile:filePath];
}

@end
