//
//  AttendanceRecord.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-06-07.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "AttendanceRecord.h"
#import "NewMember.h"
#import "Member.h"
#import "ViewController.h"
#import "AttendanceObject.h"
#import "RecordReview.h"

AttendanceObject *thisRecord;

@interface AttendanceRecord ()

@end

@implementation AttendanceRecord

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    return self;
}



- (void)viewDidLoad
{
    nsIntervalTime = [[NSDate date] timeIntervalSince1970];
    epochTime = [NSString stringWithFormat:@"%f", nsIntervalTime];
    
    [super viewDidLoad];
    if(editing == 1){
        [saveAttendanceRecord setTitle: @"Save" forState: UIControlStateNormal];
        thisRecord = [meetingList objectAtIndex:theRowNumber];
        addMembers.hidden = YES;
        epochTime = [NSString stringWithFormat:@"%f", thisRecord.time];
    }
    else{
        thisRecord = NULL;
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [memberList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    NSString *wasThere = @"";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier]; //forIndexPath:indexPath
    
    Member *aMember = [memberList objectAtIndex:indexPath.row];
    cell.textLabel.text = aMember.name;

    NSString * subtitle = [NSString stringWithFormat:@"%@ - %@", aMember.position, aMember.year];
    cell.detailTextLabel.text = subtitle;
    if(thisRecord != NULL){
        NSString *oldRecordEpochTime = [NSString stringWithFormat:@"%f", thisRecord.time];
        wasThere = [aMember.presentTable valueForKey:oldRecordEpochTime];
    }
    
    NSLog(@"current: %ld",(long)aMember.current);
    NSLog(@"wasThere: %@", wasThere);
    
    // Check to see what image should be there
    if(aMember.current == 1 || [wasThere isEqualToString:@"YES"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgView.image = [UIImage imageNamed:@"Check_mark.png"];
        cell.accessoryView = imgView;
        aMember.current = 1;
    }
    else if(aMember.current == 2 || [wasThere isEqualToString:@"LATE"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"before-too-late.png"];
        cell.accessoryView = imgView;
        aMember.current = 2;
    }
    else if(aMember.current == 3 || [wasThere isEqualToString:@"EXCUSED"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"sick.png"];
        cell.accessoryView = imgView;
        aMember.current = 3;
    }
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    Member *aMember = [memberList objectAtIndex:indexPath.row];
    
    // Assigning the proper image to indicate what a Member's status at the meeting is
    if(cell.accessoryView == NULL){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgView.image = [UIImage imageNamed:@"Check_mark.png"];
        cell.accessoryView = imgView;
        aMember.current = 1;
        
    }
    else if (aMember.current == 1){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"before-too-late.png"];
        cell.accessoryView = imgView;
        aMember.current = 2;
    }
    else if (aMember.current == 2){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"sick.png"];
        cell.accessoryView = imgView;
        aMember.current = 3;
    }
    else{
        cell.accessoryView = NULL;
        aMember.current = 0;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)saveAttendanceRecord:(id)sender{
    // No record created if no members
    if([memberList count] == 0){
        [self showAlert];
    }
    else{
        if(editing != 1){
         thisRecord = [AttendanceObject new];
        }
    
    // Iterating through each member and adding them to the record
    for(int i = 0; i < [memberList count]; i++){
        Member *aMember = [memberList objectAtIndex:i];
        NSLog(@"A member's current number: %ld", (long)aMember.current);
        if(editing == 1){
            NSString *oldRecordEpochTime = [NSString stringWithFormat:@"%f", thisRecord.time];
            NSString *wasThere = [aMember.presentTable valueForKey:oldRecordEpochTime];
            aMember.total = aMember.total - 1;
            if([wasThere isEqualToString:@"YES"]){
                thisRecord.present -= 1;
                aMember.present = aMember.present - 1;
            }
            else if([wasThere isEqualToString:@"LATE"]){
                thisRecord.present -= 1;
                aMember.present = aMember.present - 1;
                aMember.late -= 1;
            }
            else if([wasThere isEqualToString:@"EXCUSED"]){
                aMember.excused -= 1;
                thisRecord.missed -= 1;
            }
            else{
                thisRecord.missed -= 1;
            }
        }
        aMember.total = aMember.total + 1;
        
        if(aMember.current == 1){
            thisRecord.present += 1;
            aMember.present = aMember.present + 1;
            [aMember.presentTable setValue:@"YES" forKey:epochTime];
        }
        else if(aMember.current == 2){
            thisRecord.present += 1;
            aMember.present = aMember.present + 1;
            aMember.late += 1;
            [aMember.presentTable setValue:@"LATE" forKey:epochTime];
        }
        else if(aMember.current == 3){
            thisRecord.missed += 1;
            aMember.excused += 1;
            [aMember.presentTable setValue:@"EXCUSED" forKey:epochTime];
        }
        else{
            thisRecord.missed +=1;
            [aMember.presentTable setValue:@"NO" forKey:epochTime];
        }
        aMember.current = 0;
        
    }
        if(editing != 1){
            thisRecord.time = nsIntervalTime;
            [meetingList addObject:thisRecord];
            
        }
        
    }
    
    if(editing == 1){
        [self performSegueWithIdentifier:@"saveEdit" sender:self];
    }
    else{
        [self performSegueWithIdentifier:@"save" sender:self];
    }
    editing = 0;
}

- (void)showAlert {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle: @"Warning"
                                                   message: @"No record being saved"
                                                  delegate: self
                                         cancelButtonTitle: nil
                                         otherButtonTitles:@"Ok", nil];
    
    
    [alert show];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
