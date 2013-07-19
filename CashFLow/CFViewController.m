//
//  CFViewController.m
//  CashFLow
//
//  Created by Sam Watson on 15/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "CFViewController.h"
#import "CFPurchaseListCell.h"

@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hourlyRate = 25.0;
    
    [self.hourlyRateButton setTitle:[NSString stringWithFormat:@"at $%.2f/hr", self.hourlyRate] forState:UIControlStateNormal];
    
    self.purchaseList = [[NSArray alloc] init];
    
    self.purchaseListTableView.delegate = self;
    self.purchaseListTableView.dataSource = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.hourlyRateButton.enabled = NO;
        self.startTime = [[NSDate date] timeIntervalSince1970];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateCashLabel) userInfo:nil repeats:YES];
    } else {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        self.hourlyRateButton.enabled = YES;
        
        [self.timer invalidate];
        
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval timeDifference = currentTime - self.startTime;
        float cash = timeDifference * (self.hourlyRate / (60 * 60));
        cash += self.lastStopValue;
        
        self.lastStopValue = cash;
    }
}

- (IBAction)hourlyRateButtonPressed:(id)sender {
    CFNumberPad *numberPad = [[CFNumberPad alloc] init];
    numberPad.delegate = self;
    [numberPad present];
}

- (void)updateCashLabel {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeDifference = currentTime - self.startTime;
    float cash = timeDifference * (self.hourlyRate / (60 * 60));
    cash += self.lastStopValue;
    
    [self.cashLabel setText:[NSString stringWithFormat:@"$%.2f", cash]];
}

#pragma mark - CFNumberPadDelegate

- (void)numberPadValueChanged:(CFNumberPad *)numberPad {
    
}

- (void)numberPad:(CFNumberPad *)numberPad didEndWithSuccess:(BOOL)success value:(CGFloat)value {
    if (success) {
        self.hourlyRate = value;
        [self.hourlyRateButton setTitle:[NSString stringWithFormat:@"at $%.2f/hr", self.hourlyRate] forState:UIControlStateNormal];
    }
}

#pragma mark - UITableViewDataSource/UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.purchaseList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *purchaseListCellStaticIdentifier = @"PurchaseListCell";
    
    CFPurchaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:purchaseListCellStaticIdentifier];
    
    if (cell == nil) {
        cell = [[UINib nibWithNibName:@"CFPurchaseListCell" bundle:nil] instantiateWithOwner:self options:nil][0];
    }
    
    return cell;
}

@end
