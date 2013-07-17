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
#import "CFNumberPad.h"
#import "GPUImage.h"

@interface CFViewController ()

@end

@implementation CFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.hourlyRate = 30.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButtonPressed:(id)sender {
    if ([self.startButton.titleLabel.text isEqualToString:@"Start"]) {
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        self.startTime = [[NSDate date] timeIntervalSince1970];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateCashLabel) userInfo:nil repeats:YES];
    } else {
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
        
        [self.timer invalidate];
        
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval timeDifference = currentTime - self.startTime;
        float cash = timeDifference * (self.hourlyRate / (60 * 60));
        cash += self.lastStopValue;
        
        self.lastStopValue = cash;
    }
}

- (IBAction)blur:(id)sender {
    
    CFNumberPad *numberPad = [[CFNumberPad alloc] init];
    [numberPad present];
}

- (void)updateCashLabel {
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeDifference = currentTime - self.startTime;
    float cash = timeDifference * (self.hourlyRate / (60 * 60));
    cash += self.lastStopValue;
    
    [self.cashLabel setText:[NSString stringWithFormat:@"$%.2f", cash]];
}

@end
