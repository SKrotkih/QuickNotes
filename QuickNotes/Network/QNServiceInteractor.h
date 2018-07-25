//
//  QNServiceInteractor.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNServiceInteractor : NSObject

/*!
 @brief Async request to service for getting all notes
 
 @discussion It makes request to service for getting all notes
 
 To use it, simply call;
 [inst getNotes: ^(NSArray* notes){
 ...
 }];
 
 @param  dataCompletion result array with all notes
 
 */
- (void) getNotes: (void (^)(NSArray*)) dataCompletion;

@end
