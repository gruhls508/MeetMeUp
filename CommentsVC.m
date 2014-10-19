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
}


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



#pragma mark data methods

- (NSURL *)setURLSearchString {

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *eventID = [userDefaults objectForKey:keventID];

    return [NSURL URLWithString:[NSString
               stringWithFormat:@"https://api.meetup.com/2/event_comments.json?event_id=%@&key=5f537f3357d2729651f11773e1e57",
                                                                                                                    eventID]];

}


- (NSURLRequest *)urlRequest {
    NSURL *url = [self setURLSearchString];


    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    return request;
}

- (void)performRequest:(NSURLRequest *)request {

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *rsp,
                                               NSData *data, NSError *connectionError){


                               commentsDictionary = [NSJSONSerialization
                                                    JSONObjectWithData:data options:0
                                                     error:nil];


                                                    [self.tableView reloadData];
        }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[commentsDictionary objectForKey:kresults]count];
}

@end
