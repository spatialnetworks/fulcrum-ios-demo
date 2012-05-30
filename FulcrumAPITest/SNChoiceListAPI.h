//
//  SNChoiceListAPI.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNChoiceList.h"

@interface SNChoiceListAPI : NSObject

+ (void) getChoiceListsSuccess:(void (^)(NSArray* forms))success failure:(void (^)(NSError* error))failure;
+ (void) deleteChoiceList:(SNChoiceList*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) updateChoiceList:(SNChoiceList*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
+ (void) createChoiceList:(SNChoiceList*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure;

@end
