//
//  QNMainViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNMainViewController.h"
#import "QNServiceInteractor.h"
#import "QNNote.h"

@interface QNMainViewController ()

@end

@implementation QNMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    QNServiceInteractor* interactor = [[QNServiceInteractor alloc] init];
    [interactor getNotes: ^(NSArray* notes){
        for (QNNote* note in notes)
        {
            NSLog(@"Notes");
            NSLog(@"%@;%@", note.noteId, note.title);
        }
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
