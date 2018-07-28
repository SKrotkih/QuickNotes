//
//  QNViewModel.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNServiceInteractor.h"

@interface QNViewModel: NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) QNServiceInteractor* interactor;
@property (weak, nonatomic) UIView* activityIndicatorView;

- (void) bindTo: (UITableView*) tableView router: (id) router;

- (void) reloadData;

/*! @brief Send request to update note */
- (void) updateNoteRequest: (QNNote*) note;

/*! @brief Send request to add new note */
- (void) addNoteRequest: (QNNote*) note;

/*! @brief Show editor note for creating new note  */
- (void) showNoteEditorToAddNewNote;

@end
