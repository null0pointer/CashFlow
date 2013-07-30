//
//  User.h
//  CashFLow
//
//  Created by Sam Watson on 30/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Luxury;

@interface User : NSManagedObject

@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * balance;
@property (nonatomic, retain) NSSet *jobs;
@property (nonatomic, retain) NSSet *luxuries;
@property (nonatomic, retain) NSSet *expenses;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addJobsObject:(NSManagedObject *)value;
- (void)removeJobsObject:(NSManagedObject *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

- (void)addLuxuriesObject:(Luxury *)value;
- (void)removeLuxuriesObject:(Luxury *)value;
- (void)addLuxuries:(NSSet *)values;
- (void)removeLuxuries:(NSSet *)values;

- (void)addExpensesObject:(NSManagedObject *)value;
- (void)removeExpensesObject:(NSManagedObject *)value;
- (void)addExpenses:(NSSet *)values;
- (void)removeExpenses:(NSSet *)values;

@end
