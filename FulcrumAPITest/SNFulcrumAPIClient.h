//
//  SNFulcrumAPIClient.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONUtilities.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface SNFulcrumAPIClient : AFHTTPClient

+ (id)sharedInstance;

@end
