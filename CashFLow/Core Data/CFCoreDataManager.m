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
#import "SavingsGoal.h"

@implementation CFCoreDataManager

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


- (IncomeSession *)newIncomeSession {
    IncomeSession *incomeSession = [IncomeSession newEntity:@"IncomeSession" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInteger:[IncomeSession countInContext:self]] onInsert:nil];
    incomeSession.deleted = [NSNumber numberWithBool:NO];
    [self saveContext];
    
    return incomeSession;
}

- (SavingsGoal *)newSavingsGoal {
    SavingsGoal *savingsGoal = [SavingsGoal newEntity:@"SavingsGoal" inContext:self idAttribute:@"identifier" value:[NSNumber numberWithInteger:[SavingsGoal countInContext:self]] onInsert:nil];
    savingsGoal.deleted = [NSNumber numberWithBool:NO];
    savingsGoal.completed = [NSNumber numberWithBool:NO];
    [self saveContext];
    
    return savingsGoal;
}

- (void)deleteIncomeSession:(IncomeSession *)incomeSession {
    IncomeSession *inContextIncomeSession = (IncomeSession *)[self objectWithID:incomeSession.objectID];
    inContextIncomeSession.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

- (void)deleteSavingsGoal:(SavingsGoal *)savingsGoal {
    SavingsGoal *inContextSavingsGoal = (SavingsGoal *)[self objectWithID:savingsGoal.objectID];
    inContextSavingsGoal.deleted = [NSNumber numberWithBool:YES];
    [self saveContext];
}

@end
