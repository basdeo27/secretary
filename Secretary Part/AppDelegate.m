//
//  AppDelegate.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-06-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "AttendanceRecord.h"

NSString * const kMemberList = @"kMemberList";
NSString * const kMeetingList = @"kMeetingList";
NSString  *arrayPath;
NSString  *arrayPath2;

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if ([paths count] > 0)
    {
        // Path to save array data
        arrayPath = [[paths objectAtIndex:0]
                     stringByAppendingPathComponent:@"array.out"];
        arrayPath2 = [[paths objectAtIndex:0]
                     stringByAppendingPathComponent:@"array.out"];
        
        // Write array
        [memberList writeToFile:arrayPath atomically:YES];
        [meetingList writeToFile:arrayPath2 atomically:YES];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
    memberList = [NSArray arrayWithContentsOfFile:arrayPath];
    meetingList = [NSArray arrayWithContentsOfFile:arrayPath2];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    memberList = [NSArray arrayWithContentsOfFile:arrayPath];
    meetingList = [NSArray arrayWithContentsOfFile:arrayPath2];

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    arrayPath = [[paths objectAtIndex:0]
                 stringByAppendingPathComponent:@"array.out"];
    arrayPath2 = [[paths objectAtIndex:0]
                  stringByAppendingPathComponent:@"array.out"];
    
    // Write array
    [memberList writeToFile:arrayPath atomically:YES];
    [meetingList writeToFile:arrayPath2 atomically:YES];
}

@end
