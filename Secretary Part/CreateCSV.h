//
//  CreateCSV.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-08.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *selectedButton;
NSArray *sortedArray;

@interface CreateCSV : UIViewController <UITextFieldDelegate> {
    IBOutlet UITextField *fileName;
    IBOutlet UIButton *ShareFaceBook;
    IBOutlet UIButton *name;
    IBOutlet UIButton *attendanceRecord;
    IBOutlet UIButton *position;
    
}

- (IBAction)ShareFacebook:(id)sender;

@end
