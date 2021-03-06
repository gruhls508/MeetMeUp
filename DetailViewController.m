//
//  DetailViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 8/4/14.
//  Copyright (c) 2014 Intradine. All rights reserved.
//

#import "DetailViewController.h"
#import "ViewController.h"
#import "WebViewController.h"
#import "Defines.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rsvpLabel;
@property (weak, nonatomic) IBOutlet UILabel *groupInfoLabel;
@property (weak, nonatomic) IBOutlet UITextView *eventDescriptionView;
@property (weak, nonatomic) IBOutlet UIButton *websiteLinkButton;

@end

@implementation DetailViewController {

        NSString *eventID;
        NSUserDefaults *userDefaults;
}



- (void)viewDidLoad

{
    [super viewDidLoad];

    userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *searchString = [userDefaults objectForKey:ksearchString];

    NSURL *url = [NSURL URLWithString:
                searchString];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
    completionHandler:^(NSURLResponse *rsp, NSData *data, NSError *connectionError){
         
        
        self.eventNameLabel.text = [self.detailEventDictionary objectForKey:kname];
        self.groupInfoLabel.text = [[self.detailEventDictionary valueForKey:kgroup]
                                                                    valueForKey:kname];
        
        self.eventDescriptionView.text = [self.detailEventDictionary objectForKey:kdescription];
        self.rsvpLabel.text = [NSString stringWithFormat:@"%@ rsvps", [self.detailEventDictionary valueForKey:krsvpCount]];
        eventID = [self.detailEventDictionary valueForKey:kID];

     }
     ];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    if ([segue.identifier  isEqualToString:@"goToWeb"]) {

        WebViewController *wvc = segue.destinationViewController;
        wvc.webEventDictionary = self.detailEventDictionary;
    
    }

    else if ([segue.identifier isEqualToString:@"goToComments"]) {

        [userDefaults setObject:eventID forKey:keventID];
        
    }

}

- (IBAction)unwindFromComments:(UIStoryboardSegue *)segue {

}


@end
