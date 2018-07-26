//
//  QNNoteEditorViewController.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNNoteEditorViewController.h"

@interface QNNoteEditorViewController ()

@end

@implementation QNNoteEditorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self.textView setText: self.note.title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
