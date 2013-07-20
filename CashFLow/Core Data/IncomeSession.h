//
//  IncomeSession.h
//  CashFLow
//
//  Created by Sam Watson on 20/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface IncomeSession : NSManagedObject

@property (nonatomic, retain) NSDate * start_time;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * money_per_hour;
@property (nonatomic, retain) NSNumber * amount_earned;
@property (nonatomic, retain) NSNumber * identifier;

@end
