//
//  Luxury.h
//  CashFLow
//
//  Created by Sam Watson on 30/07/13.
//  Copyright (c) 2013 Sam Watson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Luxury : NSManagedObject

@property (nonatomic, retain) NSNumber * completed;
@property (nonatomic, retain) NSNumber * deleted;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) User *user;

@end
