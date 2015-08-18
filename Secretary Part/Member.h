//
//  Member.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-07-29.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Member : NSObject

@property (nonatomic, strong) NSMutableDictionary* presentTable;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *year;
@property (assign, nonatomic) NSInteger present;
@property (assign, nonatomic) NSInteger total;
@property (assign, nonatomic) NSInteger late;
@property (assign, nonatomic) NSInteger excused;
@property (assign, nonatomic) NSInteger current;


@end
