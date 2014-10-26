//
//  ViewController.m
//
//  Created by flexih on 10/14/14.
//  Copyright (c) 2014 flexih. All rights reserved.
//

#import "ViewController.h"
#import "AppearanceImageView.h"
#import "AppearanceView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
  AppearanceView *aview = [[AppearanceView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
  
  aview.appearanceConfigKeyPath = @"key1";
  
  [self.view addSubview:aview];
  
  appearance_wants_update(aview);
  
  AppearanceImageView *aiview = [[AppearanceImageView alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
  
  [self.view addSubview:aiview];
  
  aiview.appearanceConfigKeyPath = @"key2";
  
  appearance_wants_update(aiview);
  
  appearance_wants_update(self);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
