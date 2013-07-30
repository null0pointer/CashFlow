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

@interface CFCoreDataManager : NSManagedObjectContext

+ (CFCoreDataManager *)writerContext;
+ (CFCoreDataManager *)mainContext;
+ (CFCoreDataManager *)temporaryContext;

- (id)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct;
- (void)saveContext;

- (IncomeSession *)newIncomeSession;
- (Luxury *)newLuxury;
- (void)deleteIncomeSession:(IncomeSession *)incomeSession;
- (void)deleteLuxury:(Luxury *)luxury;

- (NSArray *)allIncomeSessions;
- (NSArray *)allActiveLuxuries;

@end
