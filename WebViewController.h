//
//  WebViewController.h
//  MeetMeUp
//
//  Created by Glen Ruhl on 8/4/14.
//  Copyright (c) 2014 MM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController
//@property NSArray *webEventArray;
@property NSDictionary *webEventDictionary;
@property (weak, nonatomic) NSString *eventPageURLString;

@end
