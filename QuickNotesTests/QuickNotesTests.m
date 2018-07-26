//
//  QuickNotesTests.m
//  QuickNotesTests
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "QNViewModel.h"

@interface QuickNotesTests : XCTestCase

@property(nonatomic, strong) QNServiceInteractor* interactor;

@end

@implementation QuickNotesTests

- (void) setUp {
    [super setUp];
    
    self.interactor = [[QNServiceInteractor alloc] init];
}

- (void) tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void) testGetAllNotesData {
    [self.interactor getNotes: ^(NSArray* notes){
        XCTAssertTrue(notes.count == 2, @"The notes on server should be 2");
    }];
}

@end
