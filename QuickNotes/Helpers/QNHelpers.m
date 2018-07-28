//
//  QNHelpers.m
//  QuickNotes
//
//  Created by Сергей Кротких on 28/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNHelpers.h"

@implementation QNHelpers

+ (void) alert: (NSString*) text sender: (UIViewController*) viewController
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle: NSLocalizedString(@"Quick Notes", @"Quick Notes")
                                                                   message: text
                                                            preferredStyle: UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle: @"OK"
                                                            style: UIAlertActionStyleDefault
                                                          handler: ^(UIAlertAction * action) {}];
    
    [alert addAction: defaultAction];
    [viewController presentViewController: alert
                                 animated: YES
                               completion: nil];
}

@end

