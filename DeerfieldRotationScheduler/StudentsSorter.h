//
//  StudentsSorter.h
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/30/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StudentsSorter : NSObject
//Meals waited
//Sort by grade
//Sort by co-curricular
//Sort by language
//Sort by birthday
//Sort by name
-(NSMutableArray *) sortByLastName:(NSMutableArray *)originalList;
-(NSMutableArray *) sortByFirstName:(NSMutableArray *)originalList;
-(NSMutableArray *) sortByRotationsWaited:(NSMutableArray *)originalList;
//Sort by dorms
@end
