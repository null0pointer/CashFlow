//
//  NSManagedObject+Extension.h
//  TrinityNews
//
//  Created by Jad Osseiran on 25/02/13.
//  Copyright (c) 2013 XciteDev. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (Extension)

+ (id)newEntity:(NSString *)entity
      inContext:(NSManagedObjectContext *)context
    idAttribute:(NSString *)attribute
          value:(id)value
       onInsert:(void (^)(id object))insertBlock;

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;

+ (NSArray *)findAllByAttribute:(NSString *)attribute
                          value:(id)value
                      inContext:(NSManagedObjectContext *)context;

+ (id)findFirstByAttribute:(NSString *)attribute
                     value:(id)value
                 inContext:(NSManagedObjectContext *)context;

+ (NSArray *)fetchRequest:(void (^)(NSFetchRequest *fs))fetchRequestBlock
                inContext:(NSManagedObjectContext *)context;

+ (NSUInteger)countInContext:(NSManagedObjectContext *)context;

@end
