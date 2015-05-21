//
//  AppDelegate.m
//  TheBlueRiver411
//
//  Created by Ben Russell on 5/19/15.
//  Copyright (c) 2015 Ben Russell. All rights reserved.
//

#import "AppDelegate.h"

// import needed podfiles
#import "CoreData/CoreData.h"
#import "CoreData+MagicalRecord.h"
#import "Reachability.h"

// import core data models
#import "Area.h"
#import "Location.h"
#import "Bug.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

#define aWaterURL [NSURL URLWithString:@"http://www.anglers411.com/river?waterId=2"]


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Set up core data stack
    [MagicalRecord setupAutoMigratingCoreDataStack];
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"BlueRiver_DataSetup"]) {
        
        
        
        NSError* jsonError;
        NSArray* json;
        
        Reachability *reachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus internetStatus = [reachability currentReachabilityStatus];
        
        if (internetStatus == NotReachable) {
            NSLog(@"Offline");
            NSString *filePath = [[NSBundle mainBundle] pathForResource:@"static" ofType:@"json"];
            NSString *myJSON = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:NULL];
            json = [NSJSONSerialization JSONObjectWithData:[myJSON dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&jsonError];
        } else {
            NSLog(@"Online");
            NSData* data = [NSData dataWithContentsOfURL:
                            aWaterURL];
            json = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:kNilOptions
                    error:&jsonError];
        }
        
        if (!jsonError) {
            
            [MagicalRecord cleanUp];
            NSString* folderPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
            NSError *error = nil;
            for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:folderPath error:&error])
            {
                [[NSFileManager defaultManager] removeItemAtPath:[folderPath stringByAppendingPathComponent:file] error:&error];
                if(error)
                {
                    NSLog(@"Delete error: %@", error.description);
                }
            }
            
            [MagicalRecord setupAutoMigratingCoreDataStack];
            // [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"Anglers411.sqlite"];
            
            NSLog(@"Initial Data Load");
            
            
            for (id jsonArea in json) {
                
                // Create an area
                Area *area = [Area MR_createEntity];
                area.name  = [jsonArea objectForKey:@"name"];
                area.bulletDescription  = [jsonArea objectForKey:@"bulletDescription"];
                area.uid  = [jsonArea objectForKey:@"id"];
                
                NSArray* jsonLocations  = [jsonArea objectForKey:@"locations"];
                
                for (id jsonLocation in jsonLocations) {
                    
                    // create a location
                    Location *location = [Location MR_createEntity];
                    location.uid = [jsonLocation objectForKey:@"id"];
                    location.name = [jsonLocation objectForKey:@"name"];
                    location.desc = [jsonLocation objectForKey:@"desc"];
                    location.directions = [jsonLocation objectForKey:@"directions"];
                    location.bulletDescription = [jsonLocation objectForKey:@"bulletDescription"];
                    location.area = area;
                    
                    NSArray* jsonBugs  = [jsonLocation objectForKey:@"bugs"];
                    
                    for (id jsonBug in jsonBugs) {
                        Bug *bug = [Bug MR_createEntity];
                        bug.name = [jsonBug objectForKey:@"name"];
                        bug.spring = [jsonBug objectForKey:@"spring"];
                        bug.summer = [jsonBug objectForKey:@"summer"];
                        bug.fall = [jsonBug objectForKey:@"fall"];
                        bug.winter = [jsonBug objectForKey:@"winter"];
                        bug.location = location;
                    }
                }
                
            }
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
                if (success) {
                    NSLog(@"You successfully saved your context.");
                } else if (error) {
                    NSLog(@"Error saving context: %@", error.description);
                }
            }];
            
            
            
            // [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            // Set User Default to prevent another preload of data on startup.
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"BlueRiver_DataSetup"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // [self saveContext];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Applications Document Directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    
    [MagicalRecord cleanUp];
    
}

@end
