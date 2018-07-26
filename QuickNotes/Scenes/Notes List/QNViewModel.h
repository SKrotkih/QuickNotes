//
//  QNViewModel.h
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNServiceInteractor.h"

@interface QNViewModel: NSObject <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) QNServiceInteractor* interactor;

- (void) bindTo: (UITableView*) tableView router: (id) router;
- (void) reloadData;

@end
