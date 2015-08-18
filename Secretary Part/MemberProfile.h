//
//  MemberProfile.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-05.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberProfile : UIViewController {
    
    IBOutlet UILabel *memberName;
    IBOutlet UILabel *attendanceRecord;
    IBOutlet UILabel *timesLate;
    IBOutlet UILabel *timesExcused;
}

@end
