//
//  SNFormTextFieldElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNFormTextFieldElement.h"

@implementation SNFormTextFieldElement

- (id)init
{
    self = [super init];
    if (self) {
        self.type = @"TextField";
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}

@end
