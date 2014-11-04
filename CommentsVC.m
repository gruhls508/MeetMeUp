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

    NSDictionary *JSONDictionary;
    NSURLRequest *privateVarRequest;
    UITextView *textView;
    NSArray *resultsArray;
    NSDictionary *commentDictionary;
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


                               JSONDictionary = [NSJSONSerialization
                                                    JSONObjectWithData:data options:0
                                                     error:nil];

                               NSLog(@"%@", [JSONDictionary objectForKey:kresults]);


                                                    [self.tableView reloadData];
        }];
}

- (NSString *)textForCell:(NSInteger)index cell:(UITableViewCell *)cell
{
    commentDictionary = [resultsArray objectAtIndex:index];


    /*  I've created a value for the timeInterval that I should be able to pass in as
      the "timeIntervalSince1970." Also, I am going to need to run the conversion from
      milliseconds after all, as well as ensuring that all values are indeed positive when
      passed in as timeInterval objects. */

    double rawValue = [[commentDictionary valueForKey:ktime]doubleValue];
    NSTimeInterval convertedValue = (rawValue / 1000);
    NSDate *theDate = [[NSDate alloc] initWithTimeIntervalSince1970:convertedValue];
    NSDateFormatter *formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"EEE, MMM dd yyyy hh:mm a"];
    NSLog(@"comment's date is %@", [formatter stringFromDate:theDate]);

    cell.textLabel.text = [NSString stringWithFormat:@"%@ \n\n %@", [commentDictionary
                                                                     valueForKey:kcomment],
                                                                        [formatter stringFromDate:theDate]];

    return cell.textLabel.text;
}



- (NSString *)detailTextForCell:(NSInteger)index cell:(UITableViewCell *)cell
{

        cell.detailTextLabel.text = [commentDictionary
                               valueForKey:ktime];

        return cell.detailTextLabel.text;
}


#pragma mark TableView setup methods


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger commentCount = [[JSONDictionary objectForKey:kresults]count];

    return commentCount;

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
    resultsArray = [JSONDictionary objectForKey:kresults];


    [self textForCell:index cell:cell];

    cell.textLabel.font = [UIFont systemFontOfSize:14];

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
    return size.height + 5;
}

-(CGFloat)heightForText:(NSString *)text
{
    NSInteger MAX_HEIGHT = 2000;
    NSInteger WIDTH_OF_TEXTVIEW = self.view.frame.size.width;
    textView = [[UITextView alloc]
                initWithFrame: CGRectMake(0, 0, WIDTH_OF_TEXTVIEW, MAX_HEIGHT)];
    textView.text = text;
    [textView.font fontWithSize:12.0];
    [textView sizeToFit];
    return textView.frame.size.height;
}


@end
