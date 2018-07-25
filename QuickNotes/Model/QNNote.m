//
//  QNNote.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNNote.h"

@implementation QNNote

// Convert dictionary to QNNote instance
+ (QNNote*) parse: (NSDictionary*) dict
{
    QNNote* note = [[QNNote alloc] init];
    note.noteId = dict[@"id"];
    note.title = dict[@"title"];

    return note;
}

@end
