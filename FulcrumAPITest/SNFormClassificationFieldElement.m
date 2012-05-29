//
//  SNFormClassificationFieldElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNFormClassificationFieldElement.h"

@implementation SNFormClassificationFieldElement

@synthesize classificaitonSetID = _classificaitonSetID;

- (id)init
{
    self = [super init];
    if (self) {
        self.type = @"ClassificationField";
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [super attributes];
    
    if (self.classificaitonSetID) [attributes setObject:self.classificaitonSetID forKey:@"classification_set_id"];
    
    return attributes;
}

- (void)dealloc
{
    [_classificaitonSetID release];
    [super dealloc];
}

@end
