//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 8/4/14.
//  Copyright (c) 2014 MM. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *rsvpCountsLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionView;
@property (weak, nonatomic) IBOutlet UIButton *websiteLinkButton;

@end

@implementation DetailViewController






- (void)viewDidLoad

{
    [super viewDidLoad];

    NSURL *url = [NSURL URLWithString:
                  @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=5f537f3357d2729651f11773e1e57"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *rsp, NSData *data, NSError *connectionError)
     {
         
         self.eventNameLabel.text = [self.detailEventDictionary objectForKey:@"name"];
         self.groupInfoLabel.text = [[self.detailEventDictionary valueForKey:@"group"]
                                                                    valueForKey:@"name"];
         self.eventDescriptionView.text = [self.detailEventDictionary objectForKey:@"description"];
//    NSString *rsvpNumber = [NSString stringWithFormat:@"%i", [self.detailEventDictionary valueForKey:@"yes_rsvp_count"]];
//    
//    self.rsvpCountsLabel.text = rsvpNumber;
//    
    
     }
     ];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}


@end
