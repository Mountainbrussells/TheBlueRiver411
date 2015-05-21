//
//  Area.h
//  TheBlueRiver411
//
//  Created by Ben Russell on 5/19/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location;

@interface Area : NSManagedObject

@property (nonatomic, retain) NSString * bulletDescription;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) NSSet *location;
@end

@interface Area (CoreDataGeneratedAccessors)

- (void)addLocationObject:(NSManagedObject *)value;
- (void)removeLocationObject:(NSManagedObject *)value;
- (void)addLocation:(NSSet *)values;
- (void)removeLocation:(NSSet *)values;

@end
