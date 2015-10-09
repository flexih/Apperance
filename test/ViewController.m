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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    NSString *themeName;

    if ([self.appearance rangeOfString:@"1"].location != NSNotFound) {
        themeName = @"them2.json";
    } else {
        themeName = @"them1.json";
    }

    appearance_update([AppearanceConfig configWithPath:[[NSBundle mainBundle] pathForResource:themeName ofType:nil]]);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
