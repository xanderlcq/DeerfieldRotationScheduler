//
//  FileIO.m
//  DeerfieldRotationScheduler
//
//  Created by gyektai18 on 4/19/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "FileIO.h"

@implementation FileIO
-(void)write:(NSMutableArray*)students ToFile:(NSString*)fileName{
    NSString* studStr = [[NSString alloc] init];
    [studStr writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
}
@end
