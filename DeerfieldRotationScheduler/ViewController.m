//
//  ViewController.m
//  DeerfieldRotationScheduler
//
//  Created by Xander on 3/28/17.
//  Copyright © 2017 Xander. All rights reserved.
//

#import "ViewController.h"
#import "Table.h"
#import "Student.h"
#import "Rotation.h"
#import "StudentsSorter.h"
#import "RotationGenerator.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DataProc *proc = [[DataProc alloc] init];
    NSMutableArray *studentList = [proc readNamesToStudents:@"names"];
    Rotation *testRotation = [[Rotation alloc] initEmptyRotation];
    for(int i = 0; i < 68;i++){
        [testRotation addEmptyTable:9];
    }
    
    RotationGenerator *gen = [[RotationGenerator alloc] initWithEmptyRotation:testRotation studentList:studentList andPastHistory:[[NSMutableArray alloc] init]];
    [gen generateRandomRotation];
    NSLog(@"%@",testRotation);
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
-(void) prepareForSegue:(NSStoryboardSegue *)segue sender:(id)sender{

}
@end
