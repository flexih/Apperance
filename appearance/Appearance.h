//
//  Appearance.h
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+Appearance.h"
#import "AppearanceConfig.h"

#define IMP_APPEARANCE_WILL_UPDATE_BEGIN                                       \
- (void)viewWillAppear:(BOOL)animated                                          \
{                                                                              \
  [super viewWillAppear:animated];                                             \
  appearance_will_update(self);                                                \

#define IMP_APPEARANCE_WILL_UPDATE_END                                         \
}

#define IMP_APPEARANCE_DID_UPDATE_BEGIN                                        \
- (void)viewDidAppear:(BOOL)animated                                           \
{                                                                              \
  [super viewDidAppear:animated];                                              \
  appearance_did_update(self);                                                 \

#define IMP_APPEARANCE_DID_UPDATE_END                                          \
}

#define IMP_APPEARANCE_VIEW_WILL_UPDATE_BEGIN                                  \
- (void)willMoveToWindow:(UIWindow *)newWindow                                 \
{                                                                              \
  [super willMoveToWindow:newWindow];                                          \
  appearance_view_will_update(self, newWindow);                                \

#define IMP_APPEARANCE_VIEW_WILL_UPDATE_END                                    \
}

#define IMP_APPEARANCE_VIEW_DID_UPDATE_BEGIN                                   \
- (void)didMoveToWindow                                                        \
{                                                                              \
  [super didMoveToWindow];                                                     \
  appearance_view_did_update(self);                                            \

#define IMP_APPEARANCE_VIEW_DID_UPDATE_END                                     \
}

#define DEF_APPEARANCE_WILL_UPDATE                                             \
- (void)viewWillAppear:(BOOL)animated NS_REQUIRES_SUPER;

#define DEF_APPEARANCE_DID_UPDATE                                              \
- (void)viewDidAppear:(BOOL)animated NS_REQUIRES_SUPER;

#define DEF_APPEARANCE_VIEW_WILL_UPDATE                                        \
- (void)willMoveToWindow:(UIWindow *)newWindow NS_REQUIRES_SUPER;

#define DEF_APPEARANCE_VIEW_DID_UPDATE                                         \
- (void)didMoveToWindow NS_REQUIRES_SUPER;

void appearance_initialize(void);
void appearance_update(AppearanceConfig *apperanceConfig);
void appearance_destory(void);

void appearance_wants_update(UIResponder *responder);
void appearance_wants_update_always(UIResponder *responder);
void appearance_will_update(UIResponder *responder);
void appearance_did_update(UIResponder *responder);
void appearance_view_will_update(UIResponder *responder, UIWindow *newWindow);
void appearance_view_did_update(UIResponder *responder);
