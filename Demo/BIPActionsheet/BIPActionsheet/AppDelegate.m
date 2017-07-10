//
//  AppDelegate.m
//  BIPActionsheet
//
//  Created by AHMET KAZIM GUNAY on 08/07/2017.
//  Copyright © 2017 TURKCELL. All rights reserved.
//

#import "AppDelegate.h"
#import "BIPActionSheetKit.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
