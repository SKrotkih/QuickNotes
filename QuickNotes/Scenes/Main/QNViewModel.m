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

@interface QNViewModel ()

@property(weak, nonatomic) UITableView* tableView;
@property(strong, nonatomic) NSMutableArray* notes;

@end

@implementation QNViewModel

@synthesize interactor;
CGFloat kEstimateRowHeight = 54.0;
NSString* kCellIdentifier = @"QNNoteTableViewCell";

- (void) bindTo: (UITableView*) tableView
{
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.notes = [NSMutableArray array];
    [self reloadData];
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

@end
