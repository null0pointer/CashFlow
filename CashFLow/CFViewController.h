//
//  CFViewController.h
//  CashFLow
//
//  Created by Sam Watson on 15/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFViewController : UIViewController

@property (strong, nonatomic)   IBOutlet    UILabel         *cashLabel;
@property (strong, nonatomic)   IBOutlet    UIButton        *startButton;

@property (strong, nonatomic)               NSTimer         *timer;

@property (nonatomic)                       float           lastStopValue;
@property (nonatomic)                       NSTimeInterval  startTime;
@property (nonatomic)                       float           hourlyRate;

- (IBAction)startButtonPressed:(id)sender;

- (IBAction)blur:(id)sender;

@end
