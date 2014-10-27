Appearance
=========
This library provides a solution for Theme Appearance Configuration.

It provides:

- JSON Configuration, from file or memory
- Support UIResponder and its subclasses, ViewController and View
- Change blocks
- Change only notify Responders on screen

How To Use
----------
You can just use Appearance UI classes handly

- AppearanceViewController
- AppearanceView
- AppearanceLabel
- AppearanceImageView
- AppearanceButton

Or just use defined macros for View Controller

```objective-c
IMP_APPEARANCE_WILL_UPDATE_BEGIN

IMP_APPEARANCE_WILL_UPDATE_END

IMP_APPEARANCE_DID_UPDATE_BEGIN

IMP_APPEARANCE_DID_UPDATE_END
```

for View

```objective-c
IMP_APPEARANCE_VIEW_WILL_UPDATE_BEGIN

IMP_APPEARANCE_VIEW_WILL_UPDATE_END

IMP_APPEARANCE_VIEW_DID_UPDATE_BEGIN

IMP_APPEARANCE_VIEW_DID_UPDATE_END
```
Code Sample
-----------

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // Override point for customization after application launch.
  appearance_initialize();  
  appearance_update([AppearanceConfig configWithPath:[[NSBundle mainBundle] pathForResource:@"them1.json" ofType:nil]]);
  return YES;
}

...

AppearanceView *aview = [[AppearanceView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
aview.appearanceConfigKeyPath = @"key1";
[self.view addSubview:aview];
appearance_wants_update(aview);
```

JSON Configuration Sample:
--------------------------

```objective-c
{
  "appearance":"Theme1",
  "key1":[
    ["setBackgroundColor:", [{"v":"255,100,255,0.8","c":"UIColor"}]],
    ["setTag:", [{"v":10}]]
  ],
  "key2":[
    ["setFrame:", [{"v":"{{20, 30},{50, 60}}"}]],
    ["setImage:", [{"v":"bundle://[areas.bundle]/oreo.jpg", "c":"UIImage"}]]
  ]
}
```

JSON Format Specifics:
----------------------

####UIColor

- Color Integer Value, e.g. 0x00FFFFFF
- RGB(A) String Value seperated by comma, e.g. "255,100,255,0.8"

####UIImage

- name
- file://path
- file://path/[bundle]/path
- bundle://[bundle]/path
- http://






