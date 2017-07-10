# BIPActionSheet
Custom ActionSheet with image and text support, which is easy to use and modify. We developed to use in our BIP Messenger Application

#### Demo for iPhone
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/landscapePhone.gif)
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/portraitPhone.gif)

#### Demo for iPad
![Anim](https://github.com/Turkcell/BIPActionSheet/blob/master/Gifs/ipad.gif)


## Usage

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


- You can easily control application-wide actionsheet controls with instance methods of BIPActionSheet class

```objective-c
+ (BOOL)isAnyActionsheetVisible;
+ (void)dismissLastActiveActionsheet;
+ (void)dismissAllActionsheets;
```

#### Stack Design

You can easily manage your app-wide actionsheets with stack design.

For example: it is easy to check if spesific actionsheet is already presented with below method of BIPActionSheetStack global instance:

```objective-c
- (BOOL)containsActionSheetInStack:(BIPActionSheet *)actionsheet;
```

Anytime easy to access all actionsheets on stack with below property of BIPActionSheetStack global instance:

```objective-c
@property (nonatomic, strong) NSMutableArray <BIPActionSheet *> *actionSheets;
```


For more information please check the Demo App.

## Requirements

This library requires a deployment target of iOS 7.0 or greater.


## Author

For any kind of question, you can easily access:
- Ahmet Kazım Günay, ahmetkgunay@gmail.com

## License

BIPActionSheet is available under the MIT license. See the LICENSE file for more info.
