//
//  Tax.h
//  CashFLow
//
//  Created by Sam Watson on 30/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Tax : NSManagedObject

@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * rate;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *jobs;
@end

@interface Tax (CoreDataGeneratedAccessors)

- (void)addJobsObject:(NSManagedObject *)value;
- (void)removeJobsObject:(NSManagedObject *)value;
- (void)addJobs:(NSSet *)values;
- (void)removeJobs:(NSSet *)values;

@end
