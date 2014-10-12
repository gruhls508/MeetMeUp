//
//  WebViewController.m
//  MeetMeUp
//
//  Created by Glen Ruhl on 8/4/14.
//  Copyright (c) 2014 Intradine. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIWebView *thatWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;


@end

@implementation WebViewController


- (IBAction)onBackButtonPressed:(UIButton *)sender {
    
    [self.thatWebView goBack];
    
    NSLog(@"back button pressed");
}


- (IBAction)onForwardButtonPressed:(UIButton *)sender {
    
    [self.thatWebView goForward];
    NSLog(@"forward button pressed");
}

- (void) loadURLstring:(NSString *)urlString {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.thatWebView loadRequest:urlRequest];
}


- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    self.spinner.hidesWhenStopped = YES;
    [self.spinner startAnimating];
    
    
    self.eventPageURLString = [NSString stringWithFormat:@"%@",
                              [self.webEventDictionary objectForKey:@"event_url"]];
    [self loadURLstring:self.eventPageURLString];
    
    
    
    //  Default settings for the buttons are that they
    //  are both disabled.
    
    
    self.backButton.enabled = NO;
    self.forwardButton.enabled = NO;
}



-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
    
    [self.spinner stopAnimating];
    
    
    //  These are the methods that enable the forward & backward
    //  buttons in the event that the WebView has valid destinations for the app to go forward and backward to.


    if ([self.thatWebView canGoBack])
    {
        self.backButton.enabled = YES;
    }
    else (self.backButton.enabled = NO);
    if ([self.thatWebView canGoForward])
    {
        self.forwardButton.enabled = YES;
    }
    else (self.forwardButton.enabled = NO);
}


@end
