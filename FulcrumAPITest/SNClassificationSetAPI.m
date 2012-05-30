//
//  SNClassificationSetAPI.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNClassificationSetAPI.h"
#import "SNFulcrumAPIClient.h"

@implementation SNClassificationSetAPI

+ (void) getClassificationSetsSuccess:(void (^)(NSArray* sets))success failure:(void (^)(NSError* error))failure {
    NSMutableArray* results = [NSMutableArray array];
    
    [[SNFulcrumAPIClient sharedInstance] getPath:@"classification_sets" parameters:nil
                                         success:^(AFHTTPRequestOperation *operation, id response) {
                                             
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
    NSString* path = [NSString stringWithFormat:@"classification_sets/%@", set.id];
    
    [[SNFulcrumAPIClient sharedInstance] deletePath:path parameters:nil 
                                            success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                                if (success) success();
                                            } 
                                            failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                                if (failure) failure(error);
                                            }];
}

+ (void) updateClassificationSet:(SNClassificationSet*)set success:(void (^)())success failure:(void (^)(NSError* error))failure {
    NSString* path = [NSString stringWithFormat:@"forms/%@", set.id];
    
    [[SNFulcrumAPIClient sharedInstance] putPath:path parameters:nil
                                         success:^(AFHTTPRequestOperation* operation, id responseObject) {
                                             if (success) success();
                                         } 
                                         failure: ^(AFHTTPRequestOperation* operation, NSError* error) {
                                             if (failure) failure(error);
                                         }];
}

+ (void) createClassificationSet:(SNClassificationSet*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure
{
    [[SNFulcrumAPIClient sharedInstance] postPath:@"classification_sets" parameters:form.attributes 
                                          success:^(AFHTTPRequestOperation* operation, id responseObject){
                                              if (success) success();
                                          }
                                          failure:^(AFHTTPRequestOperation* operation, NSError* error) {
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
