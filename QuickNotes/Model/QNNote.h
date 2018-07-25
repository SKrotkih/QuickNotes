//
//  QNNote.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNNote: NSObject

/*! @brief record id. */
@property (nonatomic, copy) NSString* noteId;
/*! @brief text content. */
@property (nonatomic, copy) NSString* title;

/*!
 @brief It converts dictionary received from server to QNNote instance object.
 
 @discussion This method accepts a dictionary received from server
 
 To use it, simply call [QNNote parse: dict];
 
 @param  dict The input value representing the note record.
 
 @return QNNote .
 */
+ (QNNote*) parse: (NSDictionary*) dict;

@end

