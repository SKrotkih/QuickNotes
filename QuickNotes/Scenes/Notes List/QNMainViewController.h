//
//  QNMainViewController.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNViewModel.h"
#import "QNNotesRouter.h"

@interface QNMainViewController : UIViewController <QNNotesRouter>

@property (nonatomic, strong) QNViewModel* viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView* buttonBackgroundView;

@end

