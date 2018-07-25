//
//  QNServiceInteractor.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNServiceInteractor : NSObject

- (void) getNotes: (void (^)(NSArray*)) dataCompletion;

@end
