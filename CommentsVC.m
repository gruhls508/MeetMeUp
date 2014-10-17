//
//  CommentsVCViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 10/16/14.
//  Copyright (c) 2014 MM. All rights reserved.
//

#import "CommentsVC.h"

@interface CommentsVC () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation CommentsVC

#pragma mark View setup

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark Table setup methods


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [UITableViewCell new];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


#pragma mark data methods

- (NSURL *)setURLSearchString {
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=5f537f3357d2729651f11773e1e57", self.eventID]];

}


@end
