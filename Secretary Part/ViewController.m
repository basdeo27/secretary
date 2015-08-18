//
//  ViewController.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-06-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "ViewController.h"
#import "AttendanceRecord.h"
#import "AttendanceObject.h"
#import "RecordReview.h"

//NSString * const kMemberList = @"kMemberList";
//NSString * const kMeetingList = @"kMeetingList";

@interface ViewController ()

@end

@implementation ViewController {
    UILabel *nameValue;
    UILabel *weightValue;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSInteger meetingListLength = [meetingList count];
    if(meetingListLength == 0){
        meetingList = [[NSMutableArray alloc] init];
    }
    NSInteger memberListLength = [memberList count];
    if(memberListLength == 0){
        memberList = [[NSMutableArray alloc] init];
    }
	// Do any additional setup after loading the view, typically from a nib.

}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [meetingList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *SimpleIdentifier = @"SimpleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier];
    
    if(cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    
    AttendanceObject *record = [meetingList objectAtIndex:indexPath.row];
    NSString *date = [[NSDate dateWithTimeIntervalSince1970:record.time] description];
    //Taking only the date yyyy/mm/dd part of the time stamp
    date = [date substringWithRange:NSMakeRange(0,10)];
    cell.textLabel.text = [NSString stringWithFormat:@"Record Date: %@", date];
    
    NSInteger total = record.present + record.missed;
    NSString * subtitle = [NSString stringWithFormat:@"Members Present: %ld/%ld", (long)record.present, (long)total];
    cell.detailTextLabel.text = subtitle;
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    theRowNumber = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"RecordReview" sender:self];
    
}







@end
