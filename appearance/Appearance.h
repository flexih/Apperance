//
//  Appearance.h
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIResponder+Appearance.h"

#define APPEARANCE_VC_WILL_UPDATE_BEGIN           \
- (void)viewWillAppear:(BOOL)animated             \
{                                                 \
  [super viewWillAppear:animated];                \
  appearance_will_update(self);                   \

#define APPEARANCE_VC_WILL_UPDATE_END             \
}

#define APPEARANCE_VC_DID_UPDATE_BEGIN            \
- (void)viewDidAppear:(BOOL)animated              \
{                                                 \
  [super viewDidAppear:animated];                 \
  appearance_did_update(self);                    \

#define APPEARANCE_VC_DID_UPDATE_END              \
}

/**UIViewController
- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
  
  appearance_will_update(self);
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  appearance_did_update(self);
}
*/

#define APPEARANCE_VIEW_WILL_UPDATE_BEGIN          \
- (void)willMoveToWindow:(UIWindow *)newWindow     \
{                                                  \
  appearance_view_will_update(self, newWindow);    \

#define APPEARANCE_VIEW_WILL_UPDATE_END            \
}

#define APPEARANCE_VIEW_DID_UPDATE_BEGIN           \
- (void)didMoveToWindow                            \
{                                                  \
  appearance_view_will_update(self, newWindow);    \

#define APPEARANCE_VIEW_DID_UPDATE_END             \
}


/**UIView,UIWindow
- (void)willMoveToWindow:(UIWindow *)newWindow
{
  appearance_view_will_update(self, newWindow);
}

- (void)didMoveToWindow
{
  appearance_view_did_update(self);
}
*/

void appearance_initialize(void);
void appearance_destory(void);
void appearance_update(id appearanceKey);

void appearance_wants_update(UIResponder *responder);
void appearance_will_update(UIResponder *responder);
void appearance_did_update(UIResponder *responder);
void appearance_view_will_update(UIResponder *responder, UIWindow *newWindow);
void appearance_view_did_update(UIResponder *responder);
