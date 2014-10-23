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
    UITextView *textView;
}


#pragma mark View setup

- (void)viewDidLoad {

    [super viewDidLoad];
    [self prefersStatusBarHidden];

    privateVarRequest = [self urlRequest];

    [self performRequest:privateVarRequest];

}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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

                               NSLog(@"%@", [commentsDictionary objectForKey:kresults]);

                                                    [self.tableView reloadData];
        }];
}

- (NSString *)textForCell:(NSInteger)index cell:(UITableViewCell *)cell
{
    cell.textLabel.text = [[[commentsDictionary objectForKey:kresults]
                            objectAtIndex:index]
                           valueForKey:kcomment];


    return cell.textLabel.text;
}


#pragma mark TableView setup methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *resultsArray = [commentsDictionary objectForKey:kresults];

    return resultsArray.count;

}


- (void)cellAndIndex:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath cell_p:(UITableViewCell **)cell_p index_p:(NSInteger *)index_p
{
    *cell_p = [tableView dequeueReusableCellWithIdentifier:kcell];
    *index_p = indexPath.row;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    NSInteger index;
    [self cellAndIndex:tableView indexPath:indexPath cell_p:&cell index_p:&index];

    
    [self textForCell:index cell:cell];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell;
    NSInteger index;
    NSString *cellText;
    [self cellAndIndex:tableView indexPath:indexPath cell_p:&cell index_p:&index];


    cellText = [self textForCell:index cell:cell];
    CGSize size = [cellText sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17] constrainedToSize:CGSizeMake(280, 999) lineBreakMode:NSLineBreakByWordWrapping];
    return size.height + 20;
}

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    NSInteger WIDTH_OF_TEXTVIEW = self.view.frame.size.width;
    textView = [[UITextView alloc] initWithFrame: CGRectMake(0, 0, WIDTH_OF_TEXTVIEW, MAX_HEIGHT)];
    textView.text = text;
    [textView.font fontWithSize:12.0];
    [textView sizeToFit];
    return textView.frame.size.height;
}


@end
