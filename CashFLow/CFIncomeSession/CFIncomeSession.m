//
//  CFIncomeSession.m
//  CashFLow
//
//  Created by Sam Watson on 19/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "CFIncomeSession.h"
#import "CFCoreDataManager.h"

#import "IncomeSession.h"

@implementation CFIncomeSession

@synthesize moneyPerHour = _moneyPerHour;
@synthesize moneyPerSecond = _moneyPerSecond;

+ (CFIncomeSession *)shared {
    static CFIncomeSession *shared = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shared = [[CFIncomeSession alloc] init];
    });
    
    return shared;
}

- (id)init {
    self = [super init];
    if (self) {
        self.isActive = NO;
        self.moneyPerHour = 0.0;
        self.value = 0.0;
    }
    return self;
}

- (void)setMoneyPerHour:(CGFloat)moneyPerHour {
    if (self.isActive == NO) {
        _moneyPerHour = moneyPerHour;
        _moneyPerSecond = moneyPerHour / SECONDS_PER_HOUR;
    }
}

- (void)setMoneyPerSecond:(CGFloat)moneyPerSecond {
    if (self.isActive == NO) {
        _moneyPerSecond = moneyPerSecond;
        _moneyPerHour = moneyPerSecond * SECONDS_PER_HOUR;
    }
}

- (void)beginIncomeSession {
    self.isActive = YES;
    
    self.sessionStartDate = [NSDate date];
    self.sessionStartTime = [self.sessionStartDate timeIntervalSince1970];
    
    CGFloat secondsPerHundredth = (1 / _moneyPerSecond) / 100;
    NSTimeInterval updateInterval = MAX(secondsPerHundredth, CFIncomeSessionMinimumUpdateInterval);
    
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:updateInterval target:self selector:@selector(update) userInfo:nil repeats:YES];
}

- (void)endIncomeSession {
    [self.updateTimer invalidate];
    self.isActive = NO;
    
    CFCoreDataManager *temporaryContext = [CFCoreDataManager temporaryContext];
    
    IncomeSession *incomeSession = [temporaryContext newIncomeSession];
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    NSTimeInterval timeDifference = currentTime - self.sessionStartTime;
    
    incomeSession.start_time = self.sessionStartDate;
    incomeSession.duration = [NSNumber numberWithDouble:timeDifference];
    incomeSession.amount_earned = [NSNumber numberWithFloat:timeDifference * self.moneyPerSecond];
    incomeSession.money_per_hour = [NSNumber numberWithFloat:self.moneyPerHour];
    
    [temporaryContext saveContext];
}

- (void)update {
    if (self.isActive) {
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        NSTimeInterval timeDifference = currentTime - self.sessionStartTime;
        self.value = (timeDifference * self.moneyPerSecond);
        [self postUpdateNotification];
    }
}

- (void)addUpdateObserver:(id)observer withSelector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:CFIncomeSessionUpdateNotification object:nil];
}

- (void)postUpdateNotification {
    [[NSNotificationCenter defaultCenter] postNotificationName:CFIncomeSessionUpdateNotification object:self];
}

@end
