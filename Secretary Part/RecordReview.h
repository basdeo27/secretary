//
//  RecordReview.h
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import <UIKit/UIKit.h>

NSInteger memberNumber;
NSInteger editing;

@interface RecordReview : UIViewController <UITableViewDataSource, UITableViewDelegate> {
 
    IBOutlet UITableView *theTableView;
    IBOutlet UIButton *goBack;
    
}


@end
