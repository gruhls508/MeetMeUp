//
//  ViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 8/4/14.
//  Copyright (c) 2014 Intradine. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {

    NSIndexPath *currentPath;
    NSString *searchString;
    NSUserDefaults *userSearch;
    NSURLRequest *privateVarRequest;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    userSearch = [NSUserDefaults standardUserDefaults];

    [userSearch
     setObject:@"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=5f537f3357d2729651f11773e1e57" forKey:@"searchString"];


    privateVarRequest = [self urlRequest];


    [self performRequest:privateVarRequest];
}

- (IBAction)inputDidEnd:(UITextField *)textField {

    searchString = textField.text;
}



- (NSURL *)setURLSearchString {
    return [NSURL URLWithString:
            [NSString stringWithFormat:@"%@", [userSearch objectForKey:@"searchString"]]];
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


                               self.meetUpArray = [[NSJSONSerialization
                                                    JSONObjectWithData:data options:0
                                                    error:nil]

                                                   objectForKey:@"results"];

                               [self.tableView reloadData];
                           }];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *meetUpInfo = [self.meetUpArray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    cell.textLabel.text  = [meetUpInfo objectForKey:@"name"];
    cell.detailTextLabel.text = [[meetUpInfo valueForKey:@"venue"]valueForKey:@"address_1"];
    
    return cell;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.meetUpArray.count;
}



-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *vc = segue.destinationViewController;
    
    
    NSURLRequest *request;
    request = [self urlRequest];
    
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:
     ^(NSURLResponse *rsp, NSData *data, NSError *connectionError)
    {
    
        vc.detailEventArray = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil]
                                                                        objectForKey:@"results"];
        
        vc.detailEventArray = self.meetUpArray;
        
        
        vc.detailEventDictionary = [self.meetUpArray objectAtIndex:
                                   [self.tableView indexPathForSelectedRow].row];
    }];
}


@end
