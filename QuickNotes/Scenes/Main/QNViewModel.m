//
//  QNViewModel.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNViewModel.h"
#import "QNNote.h"

@interface QNViewModel ()

@property(weak, nonatomic) UITableView* tableView;

@end


@implementation QNViewModel

@synthesize interactor;

- (void) bindTo: (UITableView*) tableView
{
    self.tableView = tableView;

    [self reloadData];
}

- (void) reloadData
{
    [interactor getNotes: ^(NSArray* notes){
        for (QNNote* note in notes)
        {
            NSLog(@"Notes");
            NSLog(@"%@;%@", note.noteId, note.title);
        }
        [self.tableView reloadData];
    }];
    
}

@end
