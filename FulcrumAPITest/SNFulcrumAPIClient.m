//
//  SNFulcrumAPIClient.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFulcrumAPIClient.h"

#import "AFJSONRequestOperation.h"

#define FulcrumAPIBaseURLString @"https://api.fulcrumapp.com/api/v2"
#define FulcrumAPIToken @"PASTE_YOUR_KEY_HERE"


@implementation SNFulcrumAPIClient

+ (id)sharedInstance
{
    static SNFulcrumAPIClient *__sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedInstance = [[SNFulcrumAPIClient alloc] initWithBaseURL:
                            [NSURL URLWithString:FulcrumAPIBaseURLString]];
        __sharedInstance.parameterEncoding = AFJSONParameterEncoding;
        
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    });
    
    return __sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //custom settings
        
        if ([FulcrumAPIToken isEqualToString:@"PASTE_YOUR_KEY_HERE"])
        {
            UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"API Token not set" 
                                                            message:@"Paste your API Token in SNFulcrumAPIClient.m" 
                                                           delegate:nil 
                                                  cancelButtonTitle:@"Ok" 
                                                  otherButtonTitles: nil] autorelease];
            [alert show];
        }
        
        [self setDefaultHeader:@"X-ApiToken" value:FulcrumAPIToken];
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    }
    
    return self;
}

@end
