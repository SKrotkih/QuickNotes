//
//  QNMainViewController.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNViewModel.h"

@interface QNMainViewController : UIViewController

@property(nonatomic, strong) QNViewModel* viewModel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

