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
    [self requestType: getNotes concrete: @"" completion: ^(__nullable id json)
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


- (void) requestType: (QNRequest) type concrete: (NSString*) userInfo completion: (void (^)(__nullable id)) dataCompletion
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
            [urlString appendString: [NSString stringWithFormat: @"/%@", userInfo]];
            httpMethod = @"GET";
            break;
        case postNotes:
            [urlString appendString: @"/notes"];
            httpMethod = @"POST";
            break;
        case putNotesId:
            [urlString appendString: @"/notes"];
            [urlString appendString: [NSString stringWithFormat: @"/%@", userInfo]];
            httpMethod = @"PUT";
            break;
        case deleteNotesId:
            [urlString appendString: @"/notes"];
            [urlString appendString: [NSString stringWithFormat: @"/%@", userInfo]];
            httpMethod = @"DELETE";
            break;
    }
    
    //Methods:
    //GET /notes
    //GET /notes/{id}
    //POST /notes
    //PUT /notes/{id}
    //DELETE /notes/{id}
    
    NSURL* url = [NSURL URLWithString: urlString];
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration: config];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL: url];
    request.HTTPMethod = httpMethod;
    
    [request addValue: @"application/json" forHTTPHeaderField: @"Content-Type"];
    //    [request addValue: "111" forHTTPHeaderField: @"user-email"];
    
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
            else {
                NSLog(@"Wrong satatus code: %ld", httpResp.statusCode);
                dataCompletion(nil);
            }
        }
    }];
    [sessionTask resume];
}

@end
