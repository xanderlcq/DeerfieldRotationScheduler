//
//  ArrayCoreDataHandler.h
//  arrayCoreDataSample
//
//  Created by Xander on 12/14/16.
//  Copyright © 2016 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface ArrayCoreDataHandler : NSObject
@property id delegate;
-(void) saveArray:(NSArray *)myArray entity:(NSString *)entityName key:(NSString *) key;
-(NSArray *) loadArray:(NSString *)entityName key:(NSString *) key;
- (void)deleteAllEntities:(NSString *)nameEntity;
@end
