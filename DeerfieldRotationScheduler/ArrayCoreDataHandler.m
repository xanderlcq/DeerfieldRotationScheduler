//
//  ArrayCoreDataHandler.m
//  arrayCoreDataSample
//
//  Created by Xander on 12/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import "ArrayCoreDataHandler.h"

@implementation ArrayCoreDataHandler
- (void)deleteAllEntities:(NSString *)nameEntity
{
    NSLog(@"deleting entries");
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects)
    {
        [context deleteObject:object];
    }
    
    error = nil;
    //[context save:&error];
    if (![context save:&error]) {
        NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
    }
}
-(void) saveArray:(NSArray *)myArray entity:(NSString *)entityName key:(NSString *) key{
    NSLog(@"Saving data");
    NSManagedObjectContext *context = [self managedObjectContext];
    // Create a new managed object
    NSManagedObject *inOrders = [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:context];
    NSData *arrayData = [NSKeyedArchiver archivedDataWithRootObject:myArray];
    [inOrders setValue:arrayData forKey:key];
    NSError *error = nil;
    // Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}
-(NSArray *) loadArray:(NSString *)entityName key:(NSString *) key{
    //Fetch
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:entityName];
    NSArray *allEntries = [[context executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    NSLog(@"Total data entries: %lu",(unsigned long)[allEntries count]);
    if([allEntries count] == 0){
        return [[NSArray alloc] init];
    }
    NSManagedObject *managedObject =[allEntries objectAtIndex:0];
    NSData *arrayData = [managedObject valueForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:arrayData];
}

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = self.delegate;
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
@end
