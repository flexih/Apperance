//
//  ViewController.m
//  test
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "ViewController.h"
#import "Appearance.h"

@interface T : UIView

@end

@implementation T

- (void)willMoveToWindow:(UIWindow *)newWindow
{
  [super willMoveToWindow:newWindow];
}

@end

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  appearance_wants_update(self);
  
  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
}

- (void)timeout
{
  appearance_update(nil);
}

IMP_APPEARANCE_WILL_UPDATE_BEGIN
IMP_APPEARANCE_WILL_UPDATE_END

IMP_APPEARANCE_DID_UPDATE_BEGIN
IMP_APPEARANCE_DID_UPDATE_END

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
