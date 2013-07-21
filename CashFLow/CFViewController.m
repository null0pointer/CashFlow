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
#import "CFIncomeSession.h"
#import "SavingsGoal.h"
#import "CFCoreDataManager.h"

@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CFIncomeSession shared] addUpdateObserver:self withSelector:@selector(incomeSessionDidUpdate:)];
    
    [self.hourlyRateButton setTitle:[NSString stringWithFormat:@"at $%.2f/hr", [[CFIncomeSession shared] moneyPerHour]] forState:UIControlStateNormal];
    
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
        
        [[CFIncomeSession shared] beginIncomeSession];
    } else {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        self.hourlyRateButton.enabled = YES;
        
        [[CFIncomeSession shared] endIncomeSession];
        
        self.lastStopValue = self.lastStopValue + [[CFIncomeSession shared] value];
    }
}

- (IBAction)hourlyRateButtonPressed:(id)sender {
    CFNumberPad *numberPad = [[CFNumberPad alloc] init];
    numberPad.delegate = self;
    [numberPad present];
}

- (void)incomeSessionDidUpdate:(CFIncomeSession *)session {
    float value = self.lastStopValue + [[CFIncomeSession shared] value];
    
    [self.cashLabel setText:[NSString stringWithFormat:@"$%.2f", value]];
}

#pragma mark - CFNumberPadDelegate

- (void)numberPadValueChanged:(CFNumberPad *)numberPad {
    
}

- (void)numberPad:(CFNumberPad *)numberPad didEndWithSuccess:(BOOL)success value:(CGFloat)value {
    if (success) {
        [[CFIncomeSession shared] setMoneyPerHour:value];
        [self.hourlyRateButton setTitle:[NSString stringWithFormat:@"at $%.2f/hr", [[CFIncomeSession shared] moneyPerHour]] forState:UIControlStateNormal];
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
