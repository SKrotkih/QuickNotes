//
//  QNDependencies.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNDependencies.h"
#import "QNServiceInteractor.h"
#import "QNViewModel.h"

@implementation QNDependencies

- (void) configure: (QNMainViewController*) viewController
{
    QNViewModel* viewModel = [[QNViewModel alloc] init];
    QNServiceInteractor* interactor = [[QNServiceInteractor alloc] init];
    viewModel.interactor = interactor;
    viewController.viewModel = viewModel;
}

@end
