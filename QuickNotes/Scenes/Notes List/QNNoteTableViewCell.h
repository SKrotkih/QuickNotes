//
//  QNNoteTableViewCell.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNNote.h"

@interface QNNoteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(assign, nonatomic) QNNote* note;
@property(readonly) CGFloat height;

@end
