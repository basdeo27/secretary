//
//  CreateCSV.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-08.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "CreateCSV.h"
#import "Member.h"
#import "ViewController.h"
#import "AttendanceRecord.h"
#import "AttendanceObject.h"
#import <Social/Social.h>

AttendanceObject *record;

@interface CreateCSV ()

@end

@implementation CreateCSV

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    record = [meetingList objectAtIndex:theRowNumber];
    self->fileName.delegate = self;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //Makes the keyboard to dissapear
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)selectName:(id)sender {
    [self deselectButton:attendanceRecord];
    [self deselectButton:position];
    [self selectButton:name];
    selectedButton = @"NAME";
}

- (IBAction)selectAttendanceRecord:(id)sender {
    [self deselectButton:name];
    [self deselectButton:position];
    [self selectButton:attendanceRecord];
    selectedButton = @"ATTENDANCERECORD";
}

- (IBAction)selectPosition:(id)sender {
    [self deselectButton:name];
    [self deselectButton:attendanceRecord];
    [self selectButton:position];
    selectedButton = @"POSITION";
}

- (IBAction)ShareFacebook:(id)sender
{
    NSSortDescriptor *sortDescriptor;
    if([selectedButton isEqualToString:@"NAME"]){
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sortedArray = [memberList sortedArrayUsingDescriptors:sortDescriptors];
    }
    else if ([selectedButton isEqualToString:@"POSITION"]){
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sortedArray = [memberList sortedArrayUsingDescriptors:sortDescriptors];
    }
    else if ([selectedButton isEqualToString:@"ATTENDANCERECORD"]) {
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"present" ascending:NO];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        sortedArray = [memberList sortedArrayUsingDescriptors:sortDescriptors];
    }

    [self createCSV];
    SLComposeViewController *fbController=[SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewControllerCompletionHandler __block completionHandler=^(SLComposeViewControllerResult result){
            
            [fbController dismissViewControllerAnimated:YES completion:nil];
            
            switch(result){
                case SLComposeViewControllerResultCancelled:
                default:
                {
                    NSLog(@"Cancelled.....");
                    // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs://"]];
                    
                }
                    break;
                case SLComposeViewControllerResultDone:
                {
                    NSLog(@"Posted....");
                }
                    break;
            }};
        
        
        [fbController setInitialText:@"This is My Sample Text"];
        
        
        [fbController setCompletionHandler:completionHandler];
        [self presentViewController:fbController animated:YES completion:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sign in!" message:@"Please first Sign In!" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
        [alert show];
    }
}




-(void)createCSV {
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        [[NSFileManager defaultManager] createFileAtPath: [self dataFilePath] contents:nil attributes:nil];
    }
    
    NSMutableString *writeString = [NSMutableString string]; //don't worry about the capacity, it will expand as necessary
    [writeString appendString:[NSString stringWithFormat:@"Name,Position,Year,Attendance Status,Overall Record \n"]];
    
    for (int i=0; i< [sortedArray count]; i++) {
        Member *aMember = [sortedArray objectAtIndex:i];
        NSString *status;
        NSString *epochTime = [NSString stringWithFormat:@"%f", record.time];
        NSString *wasThere = [aMember.presentTable valueForKey:epochTime];
        if([wasThere isEqualToString:@"YES"]){
            status = @"PRESENT";
        }
        else if([wasThere isEqualToString:@"LATE"]){
            status = @"LATE";
        }
        else if([wasThere isEqualToString:@"EXCUSED"]){
            status = @"EXCUSED";
        }
        else{
            status = @"AWAY";
        }
        
        NSString *MemberEntry = [NSString stringWithFormat:@"%@, %@, %@, %@, %ld/%ld\n",aMember.name,aMember.position,aMember.year,status,(long)aMember.present, (long)aMember.total];
        
        [writeString appendString:MemberEntry]; //the \n will put a newline in
    }
    
    
    //Moved this stuff out of the loop so that you write the complete string once and only once.
    NSLog(@"writeString : %@", writeString);
    NSFileHandle *handle;
    handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath]];
    //say to handle where's the file fo write
    [handle truncateFileAtOffset:[handle seekToEndOfFile]];
    //position handle cursor to the end of file
    [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
}

-(NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"MyCsv.csv"];
}

-(void)selectButton: (UIButton *) aButton{
    aButton.layer.cornerRadius = 5;
    aButton.layer.borderWidth = 1;
    aButton.layer.borderColor = [[UIColor blackColor] CGColor];
}

-(void)deselectButton: (UIButton *) aButton{
    aButton.layer.cornerRadius = 0;
    aButton.layer.borderWidth = 0;
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
