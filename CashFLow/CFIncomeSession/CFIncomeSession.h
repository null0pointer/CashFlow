//
//  CFIncomeSession.h
//  CashFLow
//
//  Created by Sam Watson on 19/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#define CFIncomeSessionUpdateNotification @"CFIncomeSessionUpdateNotification"

#define CFIncomeSessionMinimumUpdateInterval 0.01

#define SECONDS_PER_HOUR (60 * 60)

#import <Foundation/Foundation.h>

@interface CFIncomeSession : NSObject

@property (nonatomic)           BOOL            isActive;
@property (strong, nonatomic)   NSTimer         *updateTimer;

@property (nonatomic)           NSTimeInterval  sessionStartTime;
@property (nonatomic)           CGFloat         value;

@property (nonatomic)           CGFloat         moneyPerHour;
@property (nonatomic)           CGFloat         moneyPerSecond;


+ (CFIncomeSession *)shared;

- (void)beginIncomeSession;
- (void)endIncomeSession;

- (void)addUpdateObserver:(id)observer withSelector:(SEL)selector;
- (void)postUpdateNotification;

@end
