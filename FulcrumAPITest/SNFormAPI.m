//
//  SNFormAPI.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFormAPI.h"
#import "SNFulcrumAPIClient.h"

@implementation SNFormAPI

+ (void) getFormsWithSchema:(BOOL)withData success:(void (^)(NSArray* forms))success failure:(void (^)(NSError* error))failure
{
    NSMutableArray* formResults = [NSMutableArray array];
    
    NSMutableDictionary* params = [NSMutableDictionary dictionary];
    if (!withData)
    {
        [params setObject:@"false" forKey:@"schema"];
    }
    
    [[SNFulcrumAPIClient sharedInstance] getPath:@"forms" parameters:params
                                         success:^(AFHTTPRequestOperation *operation, id response) {
                                             NSArray* forms = [response objectForKey:@"forms"];
                                             for (NSDictionary* formDict in forms)
                                             {
                                                 SNForm* form = [[SNForm alloc] initWithAttributes:formDict];
                                                 [formResults addObject:form];
                                                 NSLog(@"==");
                                                 NSLog(@"%@", formDict);
                                                 NSLog(@"==");

                                                 [form release];
                                             }
                                             
                                             if (success) {
                                                 success(formResults);
                                             }
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             if (failure) {
                                                 failure(error);
                                             }
                                         }];
}


+ (void) deleteForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSString* path = [NSString stringWithFormat:@"forms/%@", form.id];
    
    [[SNFulcrumAPIClient sharedInstance] deletePath:path parameters:nil 
                                            success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                                if (success) success();
                                            } 
                                            failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                                if (failure) failure(error);
                                            }];
}

+ (void) updateForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error))failure
{
    NSString* path = [NSString stringWithFormat:@"forms/%@", form.id];

    [[SNFulcrumAPIClient sharedInstance] putPath:path parameters:nil
                                         success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                             if (success) success();
                                         } 
                                         failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                             if (failure) failure(error);
                                         }];
}

+ (void) createForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure
{
    NSLog(@"create form with attributes: %@", form.attributes);

    [[SNFulcrumAPIClient sharedInstance] postPath:@"forms" parameters:form.attributes 
                                          success:^(AFHTTPRequestOperation* operation, id responseObject){
                                              if (success) success();
                                          }
                                          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                                              NSError* parseError = nil;
                                              NSMutableDictionary* errorsDict = AFJSONDecode(operation.responseData, &parseError);
                                              if (!parseError)
                                              {
                                                  if (failure) failure(error, [[errorsDict objectForKey:@"form"] objectForKey:@"errors"]);
                                              }
                                              else {
                                                  if (failure) failure(error, nil);
                                              }
                                          }];
}

@end
