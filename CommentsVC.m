//
//  CommentsVCViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 10/16/14.
//  Copyright (c) 2014 MM. All rights reserved.
//

#import "CommentsVC.h"

@interface CommentsVC ()

@end

@implementation CommentsVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
}

- (NSURL *)setURLSearchString {
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=5f537f3357d2729651f11773e1e57", self.eventID]];
    
}


@end
