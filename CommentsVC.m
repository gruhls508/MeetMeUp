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


#pragma mark Data Methods

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

- (void)textForCell:(NSInteger)index cell:(UITableViewCell *)cell
{
    cell.textLabel.text = [[[commentsDictionary objectForKey:kresults]
                            objectAtIndex:index]
                           valueForKey:kcomment];
}


#pragma mark TableView setup methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[commentsDictionary objectForKey:kresults]count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kcell];
    NSInteger index = indexPath.row;

    [self textForCell:index cell:cell];
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//
//}

@end
