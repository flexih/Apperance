//
//  QNAppearanceConfig.m
//
//  Created by flexih on 10/15/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "AppearanceConfig.h"

/*
 *{"key1":[["setBackgroundColor1:color2", [{"v":"color", "c":"UIColor"}, {"v":"color"}]],]}
 */

@interface AppearanceConfig()

@property (nonatomic, strong) NSMutableDictionary *configuration;

@end

@implementation AppearanceConfig

- (instancetype)init
{
  self = [super init];
  if (self != nil) {
    _configuration = @{@"appearance":@"Theme1"
                       }.mutableCopy;
  }
  return self;
}

- (void)config:(UIResponder *)responder
{
  NSArray *contexts = self.configuration[responder.appearanceConfigKeyPath];
  
  for (NSArray *context in contexts) {
    [self examineResponder:responder selectorName:context.firstObject parameters:context.count == 2 ? context.lastObject : nil];
  }
}

- (void)examineResponder:(UIResponder *)responder selectorName:(NSString *)selectorName parameters:(NSArray *)parameters
{
  SEL selector = NSSelectorFromString(selectorName);
  NSMethodSignature *signature = [responder methodSignatureForSelector:selector];
  NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
  
  [invocation setTarget:responder];
  [invocation setSelector:selector];
  
  NSAssert(parameters.count == [signature numberOfArguments], @"parameters count not equal");
  
  for (int j = 2; j < [signature numberOfArguments]; j++) {
    const char *type = [signature getArgumentTypeAtIndex:j];
    NSDictionary *parameter = parameters[j - 2];
    id value = parameter[@"v"];
    id className = parameter[@"c"];
    
    NSAssert(strlen(type) == 1, @"only support basic type");
    
    char ch;int i;short s;long l;long long ll;float f;double d;const char *p;id obj;Class cls;SEL selector;
    void *pvalue;
    
    switch (type[0]) {
      case 'B':
      case 'c':
      case 'C': {
        ch = [(NSNumber *)value charValue];
        pvalue = &ch;
        break;
      }
      case 'i':
      case 'I': {
        i = [(NSNumber *)value intValue];
        pvalue = &i;
        break;
      }
      case 's':
      case 'S': {
        s = [(NSNumber *)value shortValue];
        pvalue = &s;
        break;
      }
      case 'l':
      case 'L': {
        l = [(NSNumber *)value longValue];
        pvalue = &l;
        break;
      }
      case 'q':
      case 'Q': {
        ll = [(NSNumber *)value longLongValue];
        pvalue = &ll;
        break;
      }
      case 'f': {
        f = [(NSNumber *)value floatValue];
        pvalue = &f;
        break;
      }
      case 'd': {
        d = [(NSNumber *)value doubleValue];
        pvalue = &d;
        break;
      }
      case '*': {
        p = [(NSString *)value UTF8String];
        pvalue = &p;
        break;
      }
      case '#': {
        cls = NSClassFromString(value);
        pvalue = &cls;
        break;
      }
      case ':': {
        selector = NSSelectorFromString(value);
        pvalue = &selector;
        break;
      }
      case '@': {
        Class c = NSClassFromString(className);
        if (c == [UIColor class]) {
          if ([value isKindOfClass:[NSString class]]) {
            //grayColor
            //rr,gg,bb,aa
            SEL classSelector = NSSelectorFromString(value);

            NSAssert([c respondsToSelector:classSelector], @"UIColor dose not respond to %s", sel_getName(classSelector));
            
            obj = [c performSelector:classSelector];
            
          } else if ([value isKindOfClass:[NSNumber class]]) {
            //hex color
          }
          
        } else if (c == [UIImage class]) {
          //value is path
        }
        pvalue = &obj;
        break;
      }
      default:
        NSAssert(0, @"only support basic type");
    }
    
    [invocation setArgument:pvalue atIndex:j];
  }
  
  [invocation invoke];
}

- (NSString *)appearance
{
  return self.configuration[@"appearance"];
}

@end
