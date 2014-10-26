//
//  Appearance.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "Appearance.h"

static NSPointerArray *appearance_list;
static AppearanceConfig *appearance_config;

static
void appearance_setup_config(UIResponder *responder);

static inline
BOOL appearance_is_valid(UIResponder *responder);

static inline
BOOL appearance_should_update(UIResponder *responder);

void appearance_initialize(void)
{
  appearance_list = [NSPointerArray weakObjectsPointerArray];
  appearance_config = [[AppearanceConfig alloc] init];
  //initialize
  //read ini
}

void appearance_destory(void)
{
  appearance_list = nil;
  appearance_config = nil;
  //deinitialize
}

void appearance_update(id appearanceKey)
{
  if ([appearanceKey isEqual:appearance_config.appearance]) {
    return;
  }
  
  for (long i = appearance_list.count - 1; i > -1; i--) {
    UIResponder *responder = [appearance_list pointerAtIndex:i];
    
    if (responder.apperanceWillChange != nil) {
      responder.apperanceWillChange(appearance_config.appearance);
    }
    
    if (appearance_should_update(responder)) {
      appearance_setup_config(responder);
    }
    
    if (responder.apperanceDidChanged != nil) {
      responder.apperanceDidChanged(appearance_config.appearance);
    }
  }
}

void appearance_wants_update(UIResponder *responder)
{
  [appearance_list addPointer:(__bridge void *)responder];
  [responder setValue:[NSNumber numberWithUnsignedChar:kAppearanceStateWantsUpdate]
               forKey:NSStringFromSelector(@selector(appearanceState))];
}

void appearance_wants_update_always(UIResponder *responder)
{
  [appearance_list addPointer:(__bridge void *)responder];
  [responder setValue:[NSNumber numberWithUnsignedChar:kAppearanceStateWantsUpdateAlways]
               forKey:NSStringFromSelector(@selector(appearanceState))];
}

void appearance_will_update(UIResponder *responder)
{
  if (appearance_is_valid(responder)) {
    appearance_setup_config(responder);
    
    if (responder.apperanceWillChange != nil) {
      responder.apperanceWillChange(appearance_config.appearance);
    }
  }
}

void appearance_did_update(UIResponder *responder)
{
  if (appearance_is_valid(responder)) {
    id oldAppearanceKey = responder.appearance;
    [responder setValue:appearance_config.appearance forKey:NSStringFromSelector(@selector(appearance))];
    
    if (responder.apperanceDidChanged != nil) {
      responder.apperanceDidChanged(oldAppearanceKey);
    }
  }
}

void appearance_view_will_update(UIResponder *responder, UIWindow *newWindow)
{
  if (newWindow != nil) {
    appearance_will_update(responder);
  }
}

void appearance_view_did_update(UIResponder *responder)
{
  if ([(UIView *)responder window] != nil) {
    appearance_did_update(responder);
  }
}

static BOOL appearance_is_valid(UIResponder *responder)
{
  return appearance_config.appearance != nil &&
         responder.appearanceState > 0 &&
         ![responder.appearance isEqual:appearance_config.appearance];
}

static void appearance_setup_config(UIResponder *responder)
{
  if (responder.appearanceConfigKeyPath != nil) {
    [appearance_config config:responder];
  }
}

static BOOL appearance_should_update(UIResponder *responder)
{
  if (responder.appearanceState == kAppearanceStateWantsUpdateAlways) {
    return YES;
  }
  
  if ([responder isKindOfClass:[UIViewController class]]) {
    UIViewController *viewController = (UIViewController *)responder;
    return ([viewController isViewLoaded] && viewController.view.window != nil);
  }
  
  if ([responder isKindOfClass:[UIView class]]) {
    UIView *view = (UIView *)responder;
    return view.window != nil;
  }
  
  return NO;
}

