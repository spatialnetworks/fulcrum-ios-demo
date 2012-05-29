//
//  SNFormPhotoFieldElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFormPhotoFieldElement.h"

@implementation SNFormPhotoFieldElement

- (id)init
{
    self = [super init];
    if (self) {
        self.type = @"PhotoField";
    }
    return self;
}

- (void)dealloc
{
    
    [super dealloc];
}
@end
