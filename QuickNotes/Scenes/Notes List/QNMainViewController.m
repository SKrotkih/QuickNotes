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

@interface QNMainViewController ()

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
    [viewModel bindTo: tableView router: self];
}

- (void) viewWillAppear: (BOOL)animated
{
    [super viewWillAppear: animated];
    
    [viewModel reloadData];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - QNNotesRouter protocol implementation

- (void) launchNoteEditor: (QNNote*) note
{
    [self performSegueWithIdentifier: kEditNoteSeque sender: self];
}


@end
