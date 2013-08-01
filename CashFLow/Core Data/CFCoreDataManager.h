//
//  CFCoreDataManager.h
//  CashFLow
//
//  Created by Sam Watson on 20/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <CoreData/CoreData.h>

@class IncomeSession;
@class Luxury;
@class Job;
@class Tax;
@class User;

@interface CFCoreDataManager : NSManagedObjectContext

@property (weak, nonatomic) User    *user;

+ (CFCoreDataManager *)writerContext;
+ (CFCoreDataManager *)mainContext;
+ (CFCoreDataManager *)temporaryContext;

- (id)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct;
- (void)saveContext;

- (User *)user;

- (Job *)newJob;

- (IncomeSession *)newIncomeSessionForJob:(Job *)job;
- (void)deleteIncomeSession:(IncomeSession *)incomeSession;

- (Luxury *)newLuxury;
- (void)deleteLuxury:(Luxury *)luxury;

- (NSArray *)allIncomeSessions;
- (NSArray *)allActiveLuxuries;

@end
