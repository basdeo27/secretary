//
//  ViewController.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-06-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>

//NSMutableArray *memberList;

NSMutableArray *meetingList;
NSInteger theRowNumber;


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UITableView *tableOfMembers;
}



@end
