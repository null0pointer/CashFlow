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
#import "CFSavingsGoalEditView.h"

@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[CFIncomeSession shared] addUpdateObserver:self withSelector:@selector(incomeSessionDidUpdate:)];
    
    [self.hourlyRateButton setTitle:[NSString stringWithFormat:@"at $%.2f/hr", [[CFIncomeSession shared] moneyPerHour]] forState:UIControlStateNormal];
    
    self.purchaseList = [[CFCoreDataManager mainContext] allActiveSavingsGoals];
    
    self.purchaseListTableView.delegate = self;
    self.purchaseListTableView.dataSource = self;
    
    self.createSavingsGoalView = [[UIView alloc] initWithFrame:CGRectMake(0, -80, 320, 80)];
    UILabel *label = [[UILabel alloc] initWithFrame:self.createSavingsGoalView.bounds];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
    label.text = @"Release for new savings goal";
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    [self.createSavingsGoalView addSubview:label];
    self.createSavingsGoalView.backgroundColor = [UIColor greenColor];
    self.createSavingsGoalView.alpha = 0.0;
    
    [self.purchaseListTableView addSubview:self.createSavingsGoalView];
    
    [self setupTableShadow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableShadow {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 1, 8);
    
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[UIColor colorWithWhite:0.5 alpha:0.5].CGColor,
                            (id)[UIColor colorWithWhite:0.5 alpha:0.0].CGColor,
                            nil];
    
    gradientLayer.locations = [NSArray arrayWithObjects:
                               [NSNumber numberWithFloat:0.0f],
                               [NSNumber numberWithFloat:1.0f],
                               nil];
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, NO, 1.0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *layerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.purchaseListTableView.frame.origin.x, self.purchaseListTableView.frame.origin.y, self.purchaseListTableView.frame.size.width, gradientLayer.frame.size.height)];
    [imageView setImage:layerImage];
    
    [self.view addSubview:imageView];
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
    return 100;//self.purchaseList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *purchaseListCellStaticIdentifier = @"PurchaseListCell";
    
    CFPurchaseListCell *cell = [tableView dequeueReusableCellWithIdentifier:purchaseListCellStaticIdentifier];
    
    if (cell == nil) {
        cell = [[UINib nibWithNibName:@"CFPurchaseListCell" bundle:nil] instantiateWithOwner:self options:nil][0];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    float yOffset = scrollView.contentOffset.y;
    
    if (yOffset >= 0) {
        self.createSavingsGoalView.alpha = 0.0;
    } else if (yOffset <= -80) {
        self.createSavingsGoalView.alpha = 1.0;
    } else {
        self.createSavingsGoalView.alpha = (yOffset / -80.0);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.contentOffset.y <= -80) {
        CFSavingsGoalEditView *editView = [[CFSavingsGoalEditView alloc] initWithNewSavingsGoal];
        [editView present];
    }
}

@end
