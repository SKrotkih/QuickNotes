//
//  QNNoteEditorViewController.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNNote.h"

@interface QNNoteEditorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property(assign, nonatomic) QNNote* note;

@end
