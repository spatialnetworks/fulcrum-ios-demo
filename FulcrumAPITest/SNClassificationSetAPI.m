//
//  SNClassificationSetAPI.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNClassificationSetAPI.h"
#import "SNFulcrumAPIClient.h"

#define CLASSIFICATION_SET_PATH @"classification_sets"

@implementation SNClassificationSetAPI

+ (void) getClassificationSetsSuccess:(void (^)(NSArray* sets))success failure:(void (^)(NSError* error))failure {
    NSMutableArray* results = [NSMutableArray array];
    
    [[SNFulcrumAPIClient sharedInstance] getPath:CLASSIFICATION_SET_PATH parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id response) {
                                             [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];

//                                             NSLog(@"RESPONSE: %@", response);
                                             
                                             NSArray* sets = [response objectForKey:@"classification_sets"];

                                             for (NSDictionary* classificationSetDict in sets)
                                             {
                                                 SNClassificationSet* classification = [[SNClassificationSet alloc] initWithAttributes:classificationSetDict];
                                                 [results addObject:classification];
//                                                 NSLog(@"==");
//                                                 NSLog(@"%@", classificationSetDict);
//                                                 NSLog(@"==");
                                                 
                                                 [classification release];
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

+ (void) deleteClassificationSet:(SNClassificationSet*)set success:(void (^)())success failure:(void (^)(NSError* error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@", CLASSIFICATION_SET_PATH, set.id];
    
    [[SNFulcrumAPIClient sharedInstance] deletePath:path parameters:nil 
                                            success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                                if (success) success();
                                            } 
                                            failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                                //NSLog(@"resp: %@", operation.responseString);
                                                if (failure) failure(error);
                                            }];
}

+ (void) updateClassificationSet:(SNClassificationSet*)set success:(void (^)())success failure:(void (^)(NSError* error))failure {
    NSString* path = [NSString stringWithFormat:@"%@/%@", CLASSIFICATION_SET_PATH, set.id];
    
    [[SNFulcrumAPIClient sharedInstance] putPath:path parameters:set.attributes
                                         success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                             if (success) success();
                                         } 
                                         failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                             if (failure) failure(error);
                                         }];
}

+ (void) createClassificationSet:(SNClassificationSet*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure
{
    [[SNFulcrumAPIClient sharedInstance] postPath:CLASSIFICATION_SET_PATH parameters:form.attributes 
                                          success:^(AFHTTPRequestOperation* operation, id responseObject){
                                              if (success) success();
                                          }
                                          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
                                              NSLog(@"resp: %@", operation.responseString);

                                              NSError* parseError = nil;
                                              NSMutableDictionary* errorsDict = AFJSONDecode(operation.responseData, &parseError);
                                              if (!parseError)
                                              {
                                                  if (failure) failure(error, [[errorsDict objectForKey:@"classification_sets"] objectForKey:@"errors"]);
                                              }
                                              else {
                                                  if (failure) failure(error, nil);
                                              }
                                          }];
}

@end
