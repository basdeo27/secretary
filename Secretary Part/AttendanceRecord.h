//
//  AttendanceRecord.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-06-07.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *hello;
NSMutableArray *memberList;
NSTimeInterval nsIntervalTime;
NSString *epochTime;

@interface AttendanceRecord : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *theTable;
    IBOutlet UIButton *saveAttendanceRecord;
    IBOutlet UIButton *addMembers;
    NSMutableArray *theArray;
}

-(IBAction)saveAttendanceRecord:(id)sender;

@end
