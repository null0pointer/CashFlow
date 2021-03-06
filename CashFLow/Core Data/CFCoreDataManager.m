//
//  CFCoreDataManager.m
//  CashFLow
//
//  Created by Sam Watson on 20/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import "CFCoreDataManager.h"
#import "CFAppDelegate.h"
#import "NSManagedObject+Extension.h"

#import "IncomeSession.h"
#import "Luxury.h"
#import "User.h"
#import "Job.h"
#import "Expense.h"
#import "Tax.h"

@implementation CFCoreDataManager

@synthesize user = _user;

+ (CFCoreDataManager *)writerContext {
    static CFCoreDataManager *writerContext = nil;
    static dispatch_once_t onceToken;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_sync(queue, ^{
        dispatch_once(&onceToken, ^{
            writerContext = [[CFCoreDataManager alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
            
            CFAppDelegate *appDelegate = (CFAppDelegate *)[[UIApplication sharedApplication] delegate];
            [writerContext setPersistentStoreCoordinator:[appDelegate persistentStoreCoordinator]];
        });
    });
    
    return writerContext;
}

+ (CFCoreDataManager *)mainContext {
    static CFCoreDataManager *mainContext = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        mainContext = [[CFCoreDataManager alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        
        mainContext.parentContext = [CFCoreDataManager writerContext];
    });
    
    return mainContext;
}

+ (CFCoreDataManager *)temporaryContext {
    __block CFCoreDataManager *temporaryContext;
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_sync(queue, ^{
        temporaryContext = [[CFCoreDataManager alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        temporaryContext.parentContext = [CFCoreDataManager mainContext];
    });
    
    return temporaryContext;
}

- (id)initWithConcurrencyType:(NSManagedObjectContextConcurrencyType)ct {
    self = [super initWithConcurrencyType:ct];
    if (self) {
        
    }
    return self;
}

- (void)saveContext {
    NSError *error;
    
    [self save:&error];
    if (error) {
        NSLog(@"CFCoreDataManager --> Could not save context %@: %@", self, error);
    }
    
    if (self.parentContext) {
        CFCoreDataManager *parentContext = (CFCoreDataManager *)self.parentContext;
        
        [parentContext performBlockAndWait:^{
            [parentContext saveContext];
        }];
    }
}

- (User *)user {
    if (_user == nil) {
        if ([User countInContext:self] > 0) {
            _user = [[User findAllInContext:self] lastObject];
        } else {
            _user = (User *)[User newEntity:@"User" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInt:[User countInContext:self]] onInsert:nil];
            [self saveContext];
        }
    }
    
    return _user;
}

- (Job *)newJob {
    Job *job = [Job newEntity:@"Job" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInteger:[Job countInContext:self]] onInsert:nil];
    job.deleted = [NSNumber numberWithBool:YES];
    
    job.user = [self user];
    [[self user] addJobsObject:job];
    
    [self saveContext];
    
    return job;
}

- (void)deleteJob:(Job *)job {
    Job *inContextJob = (Job *)[self objectWithID:job.objectID];
    inContextJob.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (IncomeSession *)newIncomeSessionForJob:(Job *)job {
    Job *inContextJob = (Job *)[self objectWithID:job.objectID];
    
    IncomeSession *incomeSession = [IncomeSession newEntity:@"IncomeSession" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInteger:[IncomeSession countInContext:self]] onInsert:nil];
    incomeSession.deleted = [NSNumber numberWithBool:NO];
    
    [inContextJob addIncome_sessionsObject:incomeSession];
    incomeSession.job = inContextJob;
    
    [self saveContext];
    
    return incomeSession;
}

- (void)deleteIncomeSession:(IncomeSession *)incomeSession {
    IncomeSession *inContextIncomeSession = (IncomeSession *)[self objectWithID:incomeSession.objectID];
    inContextIncomeSession.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (Expense *)newExpense {
    Expense *expense = [Expense newEntity:@"Expense" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInt:[Expense countInContext:self]] onInsert:nil];
    expense.deleted = [NSNumber numberWithBool:NO];
    
    expense.user = [self user];
    [[self user] addExpensesObject:expense];
    
    [self saveContext];
    return expense;
}

- (void)deleteExpense:(Expense *)expense {
    Expense *inContextExpense = (Expense *)[self objectWithID:expense.objectID];
    inContextExpense.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (Luxury *)newLuxury {
    Luxury *luxury = [Luxury newEntity:@"Luxury" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInteger:[Luxury countInContext:self]] onInsert:nil];
    luxury.deleted = [NSNumber numberWithBool:NO];
    luxury.completed = [NSNumber numberWithBool:NO];
    
    luxury.user = [self user];
    [[self user] addLuxuriesObject:luxury];
    
    [self saveContext];
    
    return luxury;
}

- (void)deleteLuxury:(Luxury *)luxury {
    Luxury *inContextLuxury = (Luxury *)[self objectWithID:luxury.objectID];
    inContextLuxury.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (Tax *)newTax {
    Tax *tax = [Tax newEntity:@"Tax" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInt:[Tax countInContext:self]] onInsert:nil];
    tax.deleted = [NSNumber numberWithBool:NO];
    
    tax.user = [self user];
    [[self user] addTaxesObject:tax];
    
    [self saveContext];
    
    return tax;
}

- (void)deleteTax:(Tax *)tax {
    Tax *inContextTax = (Tax *)[self objectWithID:tax.objectID];
    inContextTax.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (NSArray *)allIncomeSessions {
    return [IncomeSession findAllByAttribute:@"deleted" value:[NSNumber numberWithBool:NO] inContext:self];
}

- (NSArray *)allActiveLuxuries {
    NSArray *allLuxuries = [Luxury findAllByAttribute:@"deleted" value:[NSNumber numberWithBool:NO] inContext:self];
    return [allLuxuries filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"completed == %@", [NSNumber numberWithBool:NO]]];
}

@end
