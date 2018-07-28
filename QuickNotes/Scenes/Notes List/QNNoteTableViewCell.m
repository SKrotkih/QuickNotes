//
//  QNNoteTableViewCell.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 26/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNNoteTableViewCell.h"

@implementation QNNoteTableViewCell

CGFloat kMarginSpace = 15.0;

- (void) setNote: (QNNote*) note
{
    self.titleLabel.text = note.title;
    [self.titleLabel sizeToFit];
}

- (CGFloat) height
{
    return self.titleLabel.frame.size.height + kMarginSpace;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void) setSelected: (BOOL) selected animated: (BOOL) animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
