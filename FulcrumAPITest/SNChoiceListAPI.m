//
//  SNChoiceListAPI.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceListAPI.h"
#import "SNFulcrumAPIClient.h"

#define CHOICE_LIST_PATH @"choice_lists"

@implementation SNChoiceListAPI

+ (void) getChoiceListsSuccess:(void (^)(NSArray* choiceLists))success failure:(void (^)(NSError* error))failure {
    NSMutableArray* results = [NSMutableArray array];
    
    [[SNFulcrumAPIClient sharedInstance] getPath:CHOICE_LIST_PATH parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id response) {
                                             
                                             //                                             NSLog(@"RESPONSE: %@", response);
                                             
                                             NSArray* lists = [response objectForKey:@"choice_lists"];
                                             
                                             for (NSDictionary* choiceListDict in lists)
                                             {
                                                 SNChoiceList* choiceList = [[SNChoiceList alloc] initWithAttributes:choiceListDict];
                                                 [results addObject:choiceList];
                                                 //                                                 NSLog(@"==");
                                                 //                                                 NSLog(@"%@", classificationSetDict);
                                                 //                                                 NSLog(@"==");
                                                 
                                                 [choiceList release];
                                             }
                                             
                                             if (success) {
                                                 success(results);
                                             }
                                         }
                                         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             if (failure) {
                                                 failure(error);
                                             }
                                         }];
}

+ (void) deleteChoiceList:(SNChoiceList*)choiceList success:(void (^)())success failure:(void (^)(NSError* error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@", CHOICE_LIST_PATH, choiceList.id];
    [[SNFulcrumAPIClient sharedInstance] deletePath:path parameters:nil 
                                            success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                                if (success) success();
                                            } 
                                            failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
//                                                NSLog(@"%@", operation.responseString);
                                                if (failure) failure(error);
                                            }];
}

+ (void) updateChoiceList:(SNChoiceList*)choiceList success:(void (^)())success failure:(void (^)(NSError* error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@", CHOICE_LIST_PATH, choiceList.id];
    
    [[SNFulcrumAPIClient sharedInstance] putPath:path parameters:choiceList.attributes
                                         success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                             if (success) success();
                                         } 
                                         failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                             if (failure) failure(error);
                                         }];
}

+ (void) createChoiceList:(SNChoiceList*)choiceList success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure {
    [[SNFulcrumAPIClient sharedInstance] postPath:CHOICE_LIST_PATH parameters:choiceList.attributes 
                                          success:^(AFHTTPRequestOperation* operation, id responseObject){
                                              if (success) success();
                                          }
                                          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                                              NSError* parseError = nil;
                                              NSMutableDictionary* errorsDict = AFJSONDecode(operation.responseData, &parseError);
                                              if (!parseError)
                                              {
                                                  if (failure) failure(error, [[errorsDict objectForKey:@"choice_list"] objectForKey:@"errors"]);
                                              }
                                              else {
                                                  if (failure) failure(error, nil);
                                              }
                                          }];
}


@end
