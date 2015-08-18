//
//  AttendanceObject.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AttendanceObject : NSObject

@property (assign, nonatomic) NSInteger missed;
@property (assign, nonatomic) NSInteger present;
@property (assign, nonatomic) NSTimeInterval time;

@end
