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
#import "QNNoteTableViewCell.h"
#import "QNNoteEditorViewController.h"
#import "QNNotesRouter.h"

@interface QNViewModel ()

@property(weak, nonatomic) UITableView* tableView;
@property(weak, nonatomic) QNNotesRouter* router;
@property(strong, nonatomic) NSMutableArray* notes;
@property (nonatomic, strong) QNNoteTableViewCell* prototypeCell;

@end

@implementation QNViewModel

@synthesize interactor;

NSString* kCellIdentifier = @"QNNoteTableViewCell";

// Bind the table view with view model.
- (void) bindTo: (UITableView*) tableView router: (id) router
{
    self.tableView = tableView;
    self.router = router;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.notes = [NSMutableArray array];
    [self reloadData];
}

- (void) reloadData
{
    [self startActivity];
    [interactor getNotes: ^(NSArray* notes){
        [self.notes setArray: notes];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self stopActivity];
        });
    }];
}

#pragma mark - Send request to server for updating and adding new note

- (void) updateNoteRequest: (QNNote*) note
{
    [self.interactor updateNote: note completion: ^{
        [self reloadData];
    }];
}

- (void) addNoteRequest: (QNNote*) note
{
    [self.interactor addNote: note completion: ^{
        [self reloadData];
    }];
}

#pragma mark - Show Notes Editor

- (void) showNoteEditorToEditNote: (QNNote*) note
{
    [self.router showNoteEditor: note newNote: NO];
}

- (void) showNoteEditorToAddNewNote
{
    QNNote* note = [[QNNote alloc] init];
    note.noteId = [self uniqId];
    note.title = @"";
    [self.router showNoteEditor: note newNote: YES];
}

#pragma mark - Generate uniq id

- (NSString*) uniqId
{
    NSInteger noteId = 0;
    for (QNNote* note in self.notes)
    {
        NSInteger currId = [note.noteId integerValue];
        noteId = MAX(noteId, currId);
    }
    
    // TOIDO: we should use like this:
    // NSString* noteId = [[NSUUID UUID] UUIDString];
    
    return [NSString stringWithFormat: @"%ld", noteId + 1];
}

#pragma mark - Activity Indicator

- (void) startActivity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView setHidden: NO];
    });
}

- (void) stopActivity
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicatorView setHidden: YES];
    });
}

#pragma mark - TableView Delegates protocol implementation

- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section
{
    return [self.notes count];
}

- (nonnull UITableViewCell *) tableView: (nonnull UITableView*) tableView cellForRowAtIndexPath: (nonnull NSIndexPath *)indexPath {
    QNNoteTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    if (cell == nil) {
        cell = [[QNNoteTableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: kCellIdentifier];
    }
    cell.note = [self.notes objectAtIndex: indexPath.row];
    return cell;
}

- (CGFloat) tableView: (UITableView*) tableView heightForRowAtIndexPath: (NSIndexPath*) indexPath {
    QNNoteTableViewCell* cell = [self prototypeCell];
    QNNote* note = [self.notes objectAtIndex: indexPath.row];
    cell.note = note;
    [cell layoutIfNeeded];
    return cell.height;
}

- (void) tableView: (nonnull UITableView*) tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    QNNote* note = [self.notes objectAtIndex: indexPath.row];
    [self showNoteEditorToEditNote: note];
}

#pragma mark - Enable editing

- (BOOL) tableView: (UITableView*) tableView canEditRowAtIndexPath: (NSIndexPath*) indexPath
{
    return YES;
}

- (void) tableView: (UITableView*) tableView commitEditingStyle: (UITableViewCellEditingStyle) editingStyle forRowAtIndexPath: (NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        QNNote* note = [self.notes objectAtIndex: indexPath.row];
        [self.interactor deleteNote: note completion: ^{
            [self reloadData];
        }];
    }
}

#pragma mark -

- (QNNoteTableViewCell*) prototypeCell
{
    if (!_prototypeCell)
    {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier: kCellIdentifier];
    }
    return _prototypeCell;
}

@end
