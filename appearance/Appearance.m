//
//  Appearance.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "Appearance.h"

@interface UIResponder (AppearanceWriter)
@property (nonatomic, strong) id appearance;
@property (nonatomic) unsigned char appearanceState;
@end

static NSPointerArray *appearance_list;
static AppearanceConfig *appearance_config;

static
void appearance_setup_config(UIResponder *responder);

static inline
BOOL appearance_is_valid(UIResponder *responder);

static inline
BOOL appearance_should_update(UIResponder *responder);

static
void appearance_add_responder(UIResponder *responder);

void appearance_initialize(void)
{
  appearance_list = [NSPointerArray weakObjectsPointerArray];
}

void appearance_destory(void)
{
  appearance_list = nil;
  appearance_config = nil;
}

void appearance_update(AppearanceConfig *apperanceConfig)
{
  if ([apperanceConfig.appearance isEqual:appearance_config.appearance]) {
    return;
  }

  appearance_config = apperanceConfig;  
  
  for (long i = appearance_list.count - 1; i > -1; i--) {///TODO:stable
    UIResponder *responder = [appearance_list pointerAtIndex:i];
    
    if (appearance_should_update(responder)) {
      appearance_will_update(responder);
      appearance_did_update(responder);
    }
  }
}

void appearance_wants_update(UIResponder *responder)
{
  appearance_add_responder(responder);
  responder.appearanceState = kAppearanceStateWantsUpdate;
}

void appearance_wants_update_always(UIResponder *responder)
{
  appearance_add_responder(responder);
  responder.appearanceState = kAppearanceStateWantsUpdateAlways;
}

void appearance_will_update(UIResponder *responder)
{
  if (appearance_is_valid(responder)) {
    if (responder.apperanceWillChange != nil) {
      responder.apperanceWillChange(appearance_config.appearance);
    }
    
    appearance_setup_config(responder);
  }
}

void appearance_did_update(UIResponder *responder)
{
  if (appearance_is_valid(responder)) {
    id oldAppearanceKey = responder.appearance;
    responder.appearance = appearance_config.appearance;
    
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

static void appearance_add_responder(UIResponder *responder)
{
  if (appearance_list.count > 0 && [appearance_list pointerAtIndex:appearance_list.count - 1] == NULL) {
    [appearance_list compact];
  }
  
  [appearance_list addPointer:(__bridge void *)responder];
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
    [appearance_config configResponder:responder];
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

