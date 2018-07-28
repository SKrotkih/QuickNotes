//
//  QNNoteEditorViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNNoteEditorViewController.h"
#import "QNHelpers.h"

@implementation QNNoteEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.isItNewNote ? NSLocalizedString(@"New Note", @"New Note") :  NSLocalizedString(@"Note", @"Note");
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];

//    NSString* str = @"Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris, quis nostrud exercitation ullamco laboris exercitation ullamco laboris";
    
    [self.textView setText: self.note.title];
    [self.textView becomeFirstResponder];
}

- (IBAction) backButtonPressed: (id) sender {
    [self close];
}

- (IBAction) doneButtonPressed: (id) sender {
    NSString* text = self.textView.text;
    NSInteger length = text.length;
    if (length == 0)
    {
        [QNHelpers alert: NSLocalizedString(@"You should enter at least one symbol", @"You should enter at least one symbol") sender: self];
        return;
    }
    else if (length >= 256) {
        [QNHelpers alert: NSLocalizedString(@"The text is too long. Please enter less than 256 symbols", @"The text is too long. Please enter less than 256 symbols") sender: self];
        return;
    }
    
    self.note.title = text;
    if (self.isItNewNote)
    {
        [self.viewModel addNoteRequest: self.note];
    }
    else
    {
        [self.viewModel updateNoteRequest: self.note];
    }
    [self close];
}

- (void) close
{
    [self.navigationController popViewControllerAnimated: YES];
}

@end
