//
//  QNNotesRouter.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNNote.h"

@protocol QNNotesRouter
- (void) editNote: (QNNote*) note;
- (void) addNote: (QNNote*) note;
@end

@interface QNNotesRouter: NSObject
- (void) editNote: (QNNote*) note;
- (void) addNote: (QNNote*) note;
@end
