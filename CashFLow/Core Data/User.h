//
//  User.h
//  CashFLow
//
//  Created by Sam Watson on 1/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, Job, Luxury, Tax;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSSet *expenses;
@property (nonatomic, retain) NSSet *jobs;
@property (nonatomic, retain) NSSet *luxuries;
@property (nonatomic, retain) NSSet *taxes;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addExpensesObject:(Expense *)value;
- (void)removeExpensesObject:(Expense *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

- (void)addJobsObject:(Job *)value;
- (void)removeJobsObject:(Job *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

- (void)addLuxuriesObject:(Luxury *)value;
- (void)removeLuxuriesObject:(Luxury *)value;
- (void)addLuxuries:(NSSet *)values;
- (void)removeLuxuries:(NSSet *)values;

- (void)addTaxesObject:(Tax *)value;
- (void)removeTaxesObject:(Tax *)value;
- (void)addTaxes:(NSSet *)values;
- (void)removeTaxes:(NSSet *)values;

@end
