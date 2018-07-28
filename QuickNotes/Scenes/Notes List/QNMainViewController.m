//
//  QNMainViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNMainViewController.h"
#import "QuickNotes-Swift.h"
#import "QNDependencies.h"
#import "QNNote.h"
#import "QNNoteEditorViewController.h"

@interface QNMainViewController ()

@property(nonatomic, weak) QNNote* note;
@property(nonatomic, assign) BOOL isItNewNote;

@end

@implementation QNMainViewController

@synthesize viewModel;
@synthesize tableView;

QNDependencies* dependencies;
NSString* kEditNoteSeque = @"editNote";
UIRefreshControl* refreshControl;

- (void) viewDidLoad {
    [super viewDidLoad];

    self.title = NSLocalizedString(@"Quick Notes", "Quick Notes");
    
    dependencies = [[QNDependencies alloc] init];
    [dependencies configure: self];
    [self configureAddNoteButton];
    [self configureRefreshControl];
    [self configureActivityIndicator];
    [viewModel bindTo: tableView router: self];
}

- (void) configureAddNoteButton
{
    self.buttonBackgroundView.layer.cornerRadius = 30.0;
    UITapGestureRecognizer* tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(addNote)];
    tapRecognizer.numberOfTapsRequired = 1;
    [self.buttonBackgroundView addGestureRecognizer: tapRecognizer];
}

- (void) configureRefreshControl
{
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tableView addSubview:refreshControl];
    [refreshControl addTarget: self action: @selector(refreshTable) forControlEvents:UIControlEventValueChanged];
}

- (void) configureActivityIndicator
{
    self.activityIndicatorView.layer.cornerRadius = 20.0;
    self.viewModel.activityIndicatorView = self.activityIndicatorView;
}

- (void) addNote
{
    [self.viewModel showNoteEditorToAddNewNote];
}

- (void) prepareForSegue: (UIStoryboardSegue*) segue sender: (id) sender
{
    if ([segue.identifier isEqualToString: kEditNoteSeque]) {
        QNNoteEditorViewController* viewController = (QNNoteEditorViewController*) segue.destinationViewController;
        viewController.note = self.note;
        viewController.isItNewNote = self.isItNewNote;
        viewController.viewModel = self.viewModel;
    }
}

- (void) refreshTable
{
    [refreshControl endRefreshing];
    [viewModel reloadData];
}

#pragma mark - QNNotesRouter protocol implementation

- (void) showNoteEditor: (QNNote*) note newNote: (BOOL) newNote
{
    self.isItNewNote = newNote;
    self.note = note;
    [self performSegueWithIdentifier: kEditNoteSeque sender: self];
}

@end
