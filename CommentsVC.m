//
//  CommentsVCViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 10/16/14.
//  Copyright (c) 2014 MM. All rights reserved.
//

#import "CommentsVC.h"


@interface CommentsVC () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end



@implementation CommentsVC {

    NSDictionary *commentsDictionary;
    NSURLRequest *privateVarRequest;
    NSUserDefaults *userDefaults;
}

@synthesize eventID;

#pragma mark View setup

- (void)viewDidLoad {
    [super viewDidLoad];

    privateVarRequest = [self urlRequest];

    [self performRequest:privateVarRequest];
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

            [NSString
             stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=5f537f3357d2729651f11773e1e57",
             self.eventID]];

}


- (NSURLRequest *)urlRequest {
    NSURL *url = [self setURLSearchString];


    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

- (void)performRequest:(NSURLRequest *)request {

    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *rsp,
                                               NSData *data, NSError *connectionError){



                               /* Need to check here that Comments (JSON) data ACTUALLY comes in
                                Dictionary form. It really should, but you never know. */

                               commentsDictionary = [[NSJSONSerialization
                                                    JSONObjectWithData:data options:0
                                                    error:nil]


                                                   objectForKey:kresults];

                               NSLog(@"%@", [commentsDictionary valueForKey:kcomments]);



                               [self.tableView reloadData];
                           }];
}


@end
