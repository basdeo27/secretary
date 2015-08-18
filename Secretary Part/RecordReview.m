//
//  RecordReview.m
//  Secretary Part
//
//  Created by Dylan Basdeo on 2015-08-03.
//  Copyright (c) 2015 Dylan Basdeo. All rights reserved.
//

#import "RecordReview.h"
#import "ViewController.h"
#import "AttendanceRecord.h"
#import "Member.h"
#import "AttendanceObject.h"


AttendanceObject *record;

@interface RecordReview ()

@end

@implementation RecordReview

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
    NSString *SimpleIdentifier = @"NewIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleIdentifier]; //forIndexPath:indexPath
    
    if(cell ==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleIdentifier];
    }
    
    Member *aMember = [memberList objectAtIndex:indexPath.row];
    cell.textLabel.text = aMember.name;
    
    NSString * subtitle = [NSString stringWithFormat:@"%@ - %@", aMember.position, aMember.year];
    cell.detailTextLabel.text = subtitle;
    
    // Check to see if there should be a checkmark there
    NSString *epochTime = [NSString stringWithFormat:@"%f", record.time];
    NSString *wasThere = [aMember.presentTable valueForKey:epochTime];
    NSLog(@"was There %@", wasThere);
    if([wasThere isEqualToString:@"YES"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        imgView.image = [UIImage imageNamed:@"Check_mark.png"];
        cell.accessoryView = imgView;
    }
    else if([wasThere isEqualToString:@"LATE"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"before-too-late.png"];
        cell.accessoryView = imgView;
    }
    else if([wasThere isEqualToString:@"EXCUSED"]){
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        imgView.image = [UIImage imageNamed:@"sick.png"];
        cell.accessoryView = imgView;
    }
    else{
        cell.accessoryView = NULL;
    }
    
    return cell;
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    memberNumber = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"NewIdentifier" sender:self];
    
}



-(IBAction)edit:(id)sender{
    editing = 1;
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
