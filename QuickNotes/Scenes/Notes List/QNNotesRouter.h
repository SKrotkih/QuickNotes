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
- (void) showNoteEditor: (QNNote*) note newNote: (BOOL) newNote;
@end

@interface QNNotesRouter: NSObject
- (void) showNoteEditor: (QNNote*) note newNote: (BOOL) newNote;
@end
