//
//  SNClassificationSetAPI.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNClassificationSet.h"

@interface SNClassificationSetAPI : NSObject

+ (void) getClassificationSetsSuccess:(void (^)(NSArray* classificationSets))success failure:(void (^)(NSError* error))failure;
+ (void) deleteClassificationSet:(SNClassificationSet*)classificationSet success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) updateClassificationSet:(SNClassificationSet*)classificationSet success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) createClassificationSet:(SNClassificationSet*)classificationSet success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure;

@end
