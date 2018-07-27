//
//  QNNoteEditorViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNNoteEditorViewController.h"

@implementation QNNoteEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.isItNewNote ? NSLocalizedString(@"New Note", @"New Note") :  NSLocalizedString(@"Note", @"Note");
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self.textView setText: self.note.title];
    [self.textView becomeFirstResponder];
}

- (IBAction) backButtonPressed: (id) sender {
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) doneButtonPressed: (id) sender {
    self.note.title = self.textView.text;
    if (self.isItNewNote)
    {
        [self.viewModel addNote: self.note];
    }
    else
    {
        [self.viewModel updateNote: self.note];
    }
    [self.navigationController popViewControllerAnimated: YES];
}

@end
