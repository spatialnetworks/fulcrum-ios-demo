//
//  SNFormSectionElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNFormSectionElement.h"

@implementation SNFormSectionElement

@synthesize elements = _elements;

- (id)initWithAttributes:(NSMutableDictionary*)attributes
{
    self = [super initWithAttributes:attributes];
    if (self) {
        self.type = @"Section";
        self.elements = [NSMutableArray array];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.type = @"Section";
        self.elements = [NSMutableArray array];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [super attributes];
        
    NSMutableArray* elements = [NSMutableArray array];
    
    for (SNFormElement* element in self.elements) {
        [elements addObject:element.attributes];
    }
    
    [attributes setObject:elements forKey:@"elements"];
    
    return attributes;
}

- (void)dealloc
{
    [_elements release];
    [super dealloc];
}

@end
