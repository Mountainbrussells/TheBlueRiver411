//
//  Location.h
//  TheBlueRiver411
//
//  Created by Ben Russell on 5/19/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Area, Bug;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSString * bulletDescription;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * directions;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * uid;
@property (nonatomic, retain) Area *area;
@property (nonatomic, retain) NSSet *bugs;
@end

@interface Location (CoreDataGeneratedAccessors)

- (void)addBugsObject:(Bug *)value;
- (void)removeBugsObject:(Bug *)value;
- (void)addBugs:(NSSet *)values;
- (void)removeBugs:(NSSet *)values;

@end
