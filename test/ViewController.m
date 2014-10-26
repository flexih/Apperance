//
//  ViewController.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "ViewController.h"
#import "AppearanceImageView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  AppearanceImageView *aview = [[AppearanceImageView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  
  [self.view addSubview:aview];
  
  aview.appearanceConfigKeyPath = @"key2";
  
  appearance_wants_update(aview);
  
//  [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timeout) userInfo:nil repeats:NO];
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
