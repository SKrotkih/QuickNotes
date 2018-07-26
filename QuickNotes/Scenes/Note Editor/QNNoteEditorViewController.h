//
//  QNNoteEditorViewController.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNViewModel.h"
#import "QNNote.h"

/*! @brief Edit/Add Note View Controller */
@interface QNNoteEditorViewController : UIViewController

@property (nonatomic, strong) QNViewModel* viewModel;
@property (weak, nonatomic) IBOutlet UITextView* textView;
@property (strong, nonatomic) QNNote* note;
@property (assign, nonatomic) Boolean isItNewNote;

@end
