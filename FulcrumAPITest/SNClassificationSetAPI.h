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

+ (void) getClassificationSetsSuccess:(void (^)(NSArray* forms))success failure:(void (^)(NSError* error))failure;
+ (void) deleteClassificationSet:(SNClassificationSet*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) updateClassificationSet:(SNClassificationSet*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) createClassificationSet:(SNClassificationSet*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure;

@end
