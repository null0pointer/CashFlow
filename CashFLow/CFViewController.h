//
//  CFViewController.h
//  CashFLow
//
//  Created by Sam Watson on 15/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CFNumberPad.h"

@interface CFViewController : UIViewController <CFNumberPadDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)   IBOutlet    UILabel         *cashLabel;
@property (strong, nonatomic)   IBOutlet    UIButton        *startButton;
@property (strong, nonatomic)   IBOutlet    UIButton        *hourlyRateButton;

@property (strong, nonatomic)               NSArray         *purchaseList;
@property (strong, nonatomic)   IBOutlet    UITableView     *purchaseListTableView;

@property (nonatomic)                       float           lastStopValue;

- (IBAction)startButtonPressed:(id)sender;
- (IBAction)hourlyRateButtonPressed:(id)sender;

@end
