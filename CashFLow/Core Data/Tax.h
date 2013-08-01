//
//  Tax.h
//  CashFLow
//
//  Created by Sam Watson on 1/08/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Job, User;

@interface Tax : NSManagedObject

@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *jobs;
@property (nonatomic, retain) User *user;
@end

@interface Tax (CoreDataGeneratedAccessors)

- (void)addJobsObject:(Job *)value;
- (void)removeJobsObject:(Job *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

@end
