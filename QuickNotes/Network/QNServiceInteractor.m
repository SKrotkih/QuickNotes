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

NSString* baseURL = @"http://private-9aad-note10.apiary-mock.com";

typedef enum {
    getNotes,
    getNotesId,
    postNotes,
    putNotesId,
    deleteNotesId,
} QNRequest;


- (void) getNotes: (void (^)(NSArray*)) dataCompletion
{
    [self requestType: getNotes note: nil completion: ^(__nullable id json)
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

- (void) updateNote: (QNNote*) note completion: (void (^)(void)) completion
{
    [self requestType: putNotesId note: note completion: ^(__nullable id json)
     {
         completion();
     }];
}

- (void) deleteNote: (QNNote*) note completion: (void (^)(void)) completion
{
    [self requestType: deleteNotesId note: note completion: ^(__nullable id json)
     {
         completion();
     }];
}

#pragma mark Private methods

- (NSMutableURLRequest*) request: (QNRequest) type note: (nullable QNNote*) note
{
    NSMutableString* urlString = baseURL.mutableCopy;
    NSString* httpMethod;
    
    switch (type) {
        case getNotes:
            [urlString appendString: @"/notes"];
            httpMethod = @"GET";
            break;
        case getNotesId:
            [urlString appendString: @"/notes"];
            [urlString appendString: [NSString stringWithFormat: @"/%@", note.noteId]];
            httpMethod = @"GET";
            break;
        case postNotes:
            [urlString appendString: @"/notes"];
            httpMethod = @"POST";
            break;
        case putNotesId:
            [urlString appendString: @"/notes"];
            [urlString appendString: [NSString stringWithFormat: @"/%@", note.noteId]];
            httpMethod = @"PUT";
            break;
        case deleteNotesId:
            [urlString appendString: @"/notes"];
            [urlString appendString: [NSString stringWithFormat: @"/%@", note.noteId]];
            httpMethod = @"DELETE";
            break;
    }
    
    //Methods:
    //GET /notes
    //GET /notes/{id}
    //POST /notes
    //PUT /notes/{id}
    //DELETE /notes/{id}

//    [{
//        "id": 1, "title": "Jogging in park"
//    }, {
//        "id": 2, "title": "Pick-up posters from post-office"
//    }]
    
    NSURL* url = [NSURL URLWithString: urlString];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: url];
    request.HTTPMethod = httpMethod;
    
    if (type == putNotesId)
    {
        [request setValue: @"application/json" forHTTPHeaderField: @"Accept"];
        [request setValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
        NSString* jsonPostBody = [NSString stringWithFormat: @"{\"id\":%@,\"title\":\"%@\"}", note.noteId, note.title];
        NSData* postData = [jsonPostBody dataUsingEncoding: NSUTF8StringEncoding allowLossyConversion: NO];
        [request setHTTPBody: postData];
    }
    else
    {
        [request addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    }

    return request;
}

- (void) requestType: (QNRequest) type note: (nullable QNNote*) note completion: (void (^)(__nullable id)) dataCompletion
{
    NSMutableURLRequest* request = [self request: type note: note];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration: config];
    NSURLSessionDataTask* sessionTask = [session dataTaskWithRequest: request completionHandler: ^(NSData* data, NSURLResponse* response, NSError* error)
    {
        if (error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
        else
        {
            NSHTTPURLResponse* httpResp = (NSHTTPURLResponse*) response;
            if (httpResp.statusCode == 200) {
                id jsonObject = [NSJSONSerialization JSONObjectWithData: data
                                                                options: kNilOptions
                                                                  error: &error];
                if (error) {
                    NSLog(@"Error: %@", error.localizedDescription);
                    dataCompletion(nil);
                }
                else
                {
                    dataCompletion(jsonObject);
                }
            }
            else if (httpResp.statusCode == 201)
            {
                // But nothing happened!
                NSLog(@"201 Created");
                dataCompletion(nil);
            }
            else
            {
                NSLog(@"Wrong satatus code: %ld", httpResp.statusCode);
                dataCompletion(nil);
            }
        }
    }];
    [sessionTask resume];
}

@end
