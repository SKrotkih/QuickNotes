//
//  QNMainViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNMainViewController.h"
#import "QNDependencies.h"
#import "QNNote.h"
#import "QNNoteEditorViewController.h"

@interface QNMainViewController ()

@property(nonatomic, weak) QNNote* note;

@end

@implementation QNMainViewController

@synthesize viewModel;
@synthesize tableView;

QNDependencies* dependencies;
NSString* kEditNoteSeque = @"editNote";

- (void) viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Quick Notes", "Quick Notes");
    
    dependencies = [[QNDependencies alloc] init];
    [dependencies configure: self];
    [self configureAddNoteButton];
    [viewModel bindTo: tableView router: self];
}

- (void) configureAddNoteButton
{
    self.buttonBackgroundView.layer.cornerRadius = 30.0;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(addNote)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.buttonBackgroundView addGestureRecognizer: tapRecognizer];
}

- (void) addNote
{
    [self.viewModel addNote];
}

- (void) prepareForSegue: (UIStoryboardSegue*) segue sender: (id) sender
{
    if ([segue.identifier isEqualToString: kEditNoteSeque]) {
        QNNoteEditorViewController* viewController = (QNNoteEditorViewController*) segue.destinationViewController;
        viewController.note = self.note;
        viewController.viewModel = self.viewModel;
    }
}

#pragma mark - QNNotesRouter protocol implementation

- (void) launchNoteEditor: (QNNote*) note
{
    self.note = note;
    [self performSegueWithIdentifier: kEditNoteSeque sender: self];
}

@end
