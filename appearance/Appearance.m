//
//  Appearance.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "Appearance.h"

static NSPointerArray *appearance_list;
static id appearance_key;

static void appearance_config(UIResponder *responder);
static inline BOOL appearance_should_update(UIResponder *responder);

void appearance_initialize(void)
{
  appearance_list = [NSPointerArray weakObjectsPointerArray];
  //initialize
  //read ini
}

void appearance_destory(void)
{
  //deinitialize
}

void appearance_update(id appearanceKey)
{
  for (long i = appearance_list.count - 1; i > -1; i++) {
    UIResponder *responder = [appearance_list pointerAtIndex:i];
    
    if (appearance_should_update(responder)) {
      appearance_config(responder);
    }
  }
}

void appearance_wants_update(UIResponder *responder)
{
  [appearance_list addPointer:(__bridge void *)responder];
}

void appearance_will_update(UIResponder *responder)
{
  if (![responder.apperanceKey isEqual:appearance_key]) {
    appearance_config(responder);
    
    if (responder.apperanceWillChange != nil) {
      responder.apperanceWillChange(appearance_key);
    }
  }
}

void appearance_did_update(UIResponder *responder)
{
  if (![responder.apperanceKey isEqual:appearance_key]) {
    [responder setValue:appearance_key forKey:NSStringFromSelector(@selector(apperanceKey))];
    
    appearance_config(responder);
    
    if (responder.apperanceDidChanged != nil) {
      responder.apperanceDidChanged();
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

static void appearance_config(UIResponder *responder)
{
  
}

static BOOL appearance_should_update(UIResponder *responder)
{
  if (responder.appearanceWantsUpdateAlways) {
    return responder.appearanceWantsUpdateAlways;
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

