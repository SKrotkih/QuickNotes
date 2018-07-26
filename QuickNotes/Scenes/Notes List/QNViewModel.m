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

@end

@implementation QNViewModel

@synthesize interactor;

CGFloat kEstimateRowHeight = 54.0;
NSString* kCellIdentifier = @"QNNoteTableViewCell";

- (void) bindTo: (UITableView*) tableView router: (id) router
{
    self.tableView = tableView;
    self.router = router;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.notes = [NSMutableArray array];
}

- (void) reloadData
{
    [interactor getNotes: ^(NSArray* notes){
        [self.notes setArray: notes];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
}

- (void) selectNote: (QNNote*) note
{
    [self.router launchNoteEditor: note];
}

#pragma mark- TableView Delegates

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
    QNNoteTableViewCell* cell = [tableView cellForRowAtIndexPath: indexPath];
    if (cell == nil) {
        return kEstimateRowHeight;
    }
    else
    {
        return cell.height;
    }
}

- (void) tableView: (nonnull UITableView*) tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath: indexPath animated: YES];
    QNNote* note = [self.notes objectAtIndex: indexPath.row];
    [self selectNote: note];
}

@end
