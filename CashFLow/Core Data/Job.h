//
//  Job.h
//  CashFLow
//
//  Created by Sam Watson on 30/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IncomeSession, Tax, User;

@interface Job : NSManagedObject

@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * is_salary;
@property (nonatomic, retain) NSNumber * money_per_hour;
@property (nonatomic, retain) NSNumber * salary;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * earnings_gross;
@property (nonatomic, retain) NSNumber * earnings_after_tax;
@property (nonatomic, retain) NSSet *taxes;
@property (nonatomic, retain) NSSet *income_sessions;
@property (nonatomic, retain) User *user;
@end

@interface Job (CoreDataGeneratedAccessors)

- (void)addTaxesObject:(Tax *)value;
- (void)removeTaxesObject:(Tax *)value;
- (void)addTaxes:(NSSet *)values;
- (void)removeTaxes:(NSSet *)values;

- (void)addIncome_sessionsObject:(IncomeSession *)value;
- (void)removeIncome_sessionsObject:(IncomeSession *)value;
- (void)addIncome_sessions:(NSSet *)values;
- (void)removeIncome_sessions:(NSSet *)values;

@end
