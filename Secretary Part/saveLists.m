//
//  saveLists.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-07-23.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "saveLists.h"

@implementation saveLists

- (NSString *) saveFilePath
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [[path objectAtIndex:0] stringByAppendingPathComponent:@"savefile.plist"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
	NSArray *values = [[NSArray alloc] initWithObjects:Question.text,Answer.text,nil];
	[values writeToFile:[self saveFilePath] atomically:YES];
	[values release];
    
}

@end
