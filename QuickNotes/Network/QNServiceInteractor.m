//
//  QNServiceInteractor.m
//  QuickNotes
//
//  Created by Sergey Krotkih on 25/07/2018.
//  Copyright © 2018 Sergey Krotkih. All rights reserved.
//

#import "QNServiceInteractor.h"
#import "QNNote.h"

@implementation QNServiceInteractor

NSString* notesURL = @"https://mishakrotkikh.000webhostapp.com/api";

// API Request types
typedef enum {
    getNotes,
    addNote,
    deleteNote
} QNRequest;

#pragma mark - Interface methods

- (void) getNotes: (void (^)(NSArray*)) dataCompletion
{
    [self sendRequestType: getNotes note: nil completion: ^(__nullable id json)
    {
        if (json == nil)
        {
            dataCompletion([NSArray array]);
        }
        else
        {
            NSMutableArray* notes = [NSMutableArray array];
            for (NSDictionary* dict in (NSArray*) json)
            {
                QNNote* note = [QNNote parse: dict];
                [notes addObject: note];
            }
            dataCompletion(notes);
        }
    }];
}

- (void) addNote: (QNNote*) note completion: (void (^)(void)) completion
{
    [self sendRequestType: addNote note: note completion: ^(__nullable id json)
     {
         completion();
     }];
}

- (void) updateNote: (QNNote*) note completion: (void (^)(void)) completion
{
    [self sendRequestType: addNote note: note completion: ^(__nullable id json)
     {
         completion();
     }];
}

- (void) deleteNote: (QNNote*) note completion: (void (^)(void)) completion
{
    [self sendRequestType: deleteNote note: note completion: ^(__nullable id json)
     {
         completion();
     }];
}

#pragma mark - Private methods

- (void) sendRequestType: (QNRequest) type note: (nullable QNNote*) note completion: (void (^)(__nullable id)) dataCompletion
{
    NSMutableURLRequest* request = [self request: type note: note];
    NSLog(@"%@", request);
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration: config];
    NSURLSessionDataTask* sessionTask = [session dataTaskWithRequest: request completionHandler: ^(NSData* data, NSURLResponse* response, NSError* error)
                                         {
                                             if (error) {
                                                 NSLog(@"Error: %@", error.localizedDescription);
                                                 return;
                                             }
                                             NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*) response;
                                             NSInteger statusCode = httpResponse.statusCode;
                                             if (statusCode >= 200 && statusCode <= 300) {
                                                 
                                                 NSLog(@"Satatus code: %ld", statusCode);
                                                 
                                                 id jsonObject = [NSJSONSerialization JSONObjectWithData: data
                                                                                                 options: kNilOptions
                                                                                                   error: &error];
                                                 if (error) {
                                                     NSLog(@"Error: %@", error.localizedDescription);
                                                     dataCompletion(nil);
                                                 }
                                                 else
                                                 {
                                                     NSLog(@"%@", jsonObject);
                                                     dataCompletion(jsonObject);
                                                 }
                                             }
                                             else
                                             {
                                                 NSLog(@"Wrong satatus code: %ld", statusCode);
                                                 dataCompletion(nil);
                                             }
                                         }];
    [sessionTask resume];
}

#pragma mark - Request Builder

- (NSMutableURLRequest*) request: (QNRequest) type note: (nullable QNNote*) note
{
    NSURL* url = [NSURL URLWithString: [self getRequestUrl: type]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: url];
    request.HTTPMethod = [self getRequestHttpMethod: type];
    [request setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    NSString* body = [self getRequestBody: type note: note];
    if (body.length > 0)
    {
        NSData* bodyData = [body dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion: NO];
        [request setHTTPBody: bodyData];
    }

    return request;
}

- (NSString*) getRequestUrl: (QNRequest) type
{
    NSMutableString* urlString = notesURL.mutableCopy;
    
    switch (type) {
        case getNotes:
            [urlString appendString: @"/notes"];
            break;
        case addNote:
            [urlString appendString: @"/note/create"];
            break;
        case deleteNote:
            [urlString appendString: @"/note/delete"];
            break;
    }

    return urlString;
}

- (NSString*) getRequestHttpMethod: (QNRequest) type
{
    NSString* httpMethod;
    
    switch (type) {
        case getNotes:
            httpMethod = @"GET";
            break;
        case addNote:
            httpMethod = @"POST";
            break;
        case deleteNote:
            httpMethod = @"POST";
            break;
    }
    
    return httpMethod;
}

- (NSString*) getRequestBody: (QNRequest) type note: (QNNote*) note
{
    NSString* jsonBody = @"";
    
    switch (type) {
        case getNotes:
            break;
        case addNote:
            jsonBody = [NSString stringWithFormat: @"{\"id\":%@,\"title\":\"%@\"}", note.noteId, note.title];
            NSLog(@"%@", jsonBody);
            break;
        case deleteNote:
            jsonBody = [NSString stringWithFormat: @"{\"id\":%@}", note.noteId];
            NSLog(@"%@", jsonBody);
            break;
    }
    
    return jsonBody;
}

@end
