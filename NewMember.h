//
//  NewMember.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-07-05.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>



NSMutableArray *years;
NSMutableArray *memberList2;

@interface NewMember : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource> {
        IBOutlet UITextField *memberName;
        IBOutlet UITextField *memberPosition;
        IBOutlet UITextField *memberClass;
        IBOutlet UIPickerView *pickerView;
    
        IBOutlet UIButton *goBack;
        IBOutlet UIButton *classButton;
    
    
}
//@property (copy, nonatomic) NSMutableArray *aMemberList;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (IBAction)goBack:(id)sender;
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;
- (void)showAlert;
- (IBAction)classButton:(id)sender;
@end
