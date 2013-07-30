//
//  IncomeSession.h
//  CashFLow
//
//  Created by Sam Watson on 30/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job;

@interface IncomeSession : NSManagedObject

@property (nonatomic, retain) NSNumber * amount_earned;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * money_per_hour;
@property (nonatomic, retain) NSDate * start_time;
@property (nonatomic, retain) Job *job;

@end
