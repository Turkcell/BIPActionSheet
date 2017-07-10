# BIPActionSheet
Custom ActionSheet with image and text support, which is easy to use and modify. We developed to use in our BIP Messenger Application

#### Demo for iPhone
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/landscapePhone.gif)
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/portraitPhone.gif)

#### Demo for iPad
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/ipad.gif)


### Usage

Usage is simple, just import "BIPActionSheetKit.h" to your class where you want to use this library.

For example if you want to show actionsheet when button tapped:

```objective-c

#import "BIPActionSheetKit.h"

@implementation ViewController

- (IBAction)btnTapped:(id)sender {

    BIPActionSheetItem *item = [BIPActionSheetItem itemWithTitle:@"Item1" image:[UIImage imageNamed:@"asCallIcon"] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item1 Tapped");
    }];

    BIPActionSheetItem *item2 = [BIPActionSheetItem itemWithTitle:@"Item2" image:[UIImage imageNamed:@"asCallIcon"] textColor:[UIColor blackColor] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item2 Tapped");
    }];

    BIPActionSheetItem *item3 = [BIPActionSheetItem itemWithTitle:@"Item3" image:[UIImage imageNamed:@"asCallIcon"] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item3 Tapped");
    }];

    BIPActionSheetItem *item4 = [BIPActionSheetItem itemWithTitle:@"Item4" image:[UIImage imageNamed:@"asCallIcon"] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item4 Tapped");
    }];

    BIPActionSheetItem *item5 = [BIPActionSheetItem itemWithTitle:@"Item5" image:[UIImage imageNamed:@"asCallIcon"] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item5 Tapped");
    }];

    BIPActionSheetItem *item6 = [BIPActionSheetItem itemWithTitle:@"Item6" image:[UIImage imageNamed:@"asCallIcon"] actionHandler:^(BIPActionSheet *actionSheet) {

        NSLog(@"Item6 Tapped");
    }];

    [BIPActionSheet showActionSheetWithTitle:@"This is title" items:@[item, item2, item3, item4, item5, item6] cancelButtonTitle:@"Cancel" cancelHandler:^{

        NSLog(@"Cancel Tapped");
    }];
}

@end
```
- You can check if actionsheet is visible with Actionsheet's public property 

```objective-c
@property (nonatomic, assign, readonly, getter=isVisible) BOOL visible;
```


- You can easily control application-wide actionsheet controls with class methods of BIPActionSheet class

```objective-c
+ (BOOL)isAnyActionsheetVisible;
+ (void)dismissLastActiveActionsheet;
+ (void)dismissAllActionsheets;
```

### Appearence Support 

Application-wide appearence of Actionsheet can be set.

NOTE: If you initialize BIPActionSheetItem with spesific text color, so this library firsly listens how you initialize the item to show up about appearence.

For Example: You are initializing actionSheetItem with blueColor as shown below, Then this library firstly choose this item textColor as Blue regardless you initialized appearence with black color for spesific item.

```objective-c
BIPActionSheetItem *item2 = [BIPActionSheetItem itemWithTitle:@"Item2" image:[UIImage imageNamed:@"asCallIcon"] textColor:[UIColor blueColor] actionHandler:^(BIPActionSheet *actionSheet) {

    NSLog(@"Item2 Tapped");
}];
```

```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
// Override point for customization after application launch.

    [[BIPActionSheetItemView appearance] setCancelButtonColor:[UIColor blueColor]];
    [[BIPActionSheetItemView appearance] setCancelButtonFont:[UIFont fontWithName:@"Helvetica-Bold" size:17]];

    [[BIPActionSheetItemView appearance] setItemFont:[UIFont fontWithName:@"Helvetica" size:17]];
    [[BIPActionSheetItemView appearance] setItemTextColor:[UIColor darkGrayColor]];

    [[BIPActionSheetItemView appearance] setTitleFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [[BIPActionSheetItemView appearance] setTitleTextColor:[UIColor redColor]];

    [[BIPActionSheetItemView appearance] setImageAlignment:Left];
    [[BIPActionSheetItemView appearance] setImageHeight:30.f];
    [[BIPActionSheetItemView appearance] setImageWidth:30.f];

    return YES;
}
```

### Stack Design 

You can easily manage your app-wide actionsheets with stack design.

For example: it is easy to check if spesific actionsheet is already presented with below method of BIPActionSheetStack global instance:

```objective-c
- (BOOL)containsActionSheetInStack:(BIPActionSheet *)actionsheet;
```

Anytime easy to access all actionsheets on stack with below property of BIPActionSheetStack global instance:

```objective-c
@property (nonatomic, strong) NSMutableArray <BIPActionSheet *> *actionSheets;
```

### Customize With Constants

These constants are for UI Customization of BIPActionSheet Library as shown below:
You can change them with needs of your project.

```objective-c
@interface BIPActionSheetConstants : NSObject

extern CGFloat const kBIPActionSheetPaddingOffset;
extern CGFloat const kBIPActionSheetPaddingOffsetiPAD;
extern CGFloat const kBIPActionSheetBackgroundAlpha;
extern CGFloat const kBIPActionSheetShowAnimationDuration;
extern CGFloat const kBIPActionSheetHideAnimationDuration;
extern CGFloat const kBIPActionSheetRowHeight;

@end
```

For more information please check the Demo App.

## Requirements

This library requires a deployment target of iOS 7.0 or greater.


## Author

For any kind of question, you can easily access:
- Ahmet Kazım Günay, ahmetkgunay@gmail.com

## License

BIPActionSheet is available under the MIT license. See the LICENSE file for more info.
