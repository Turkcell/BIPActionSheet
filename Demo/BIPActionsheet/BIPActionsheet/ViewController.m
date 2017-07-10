//
//  ViewController.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "ViewController.h"
#import "BIPActionSheetKit.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
