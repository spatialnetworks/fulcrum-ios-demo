//
//  SNFormAPI.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNForm.h"

@interface SNFormAPI : NSObject

- (void) getFormsWithSchema:(BOOL)withData success:(void (^)(NSArray* forms))success failure:(void (^)(NSError* error))failure;
- (void) deleteForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void) updateForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error))failure;
- (void) createForm:(SNForm*)form success:(void (^)())success failure:(void (^)(NSError* error, NSArray* validationErrors))failure;

@end
