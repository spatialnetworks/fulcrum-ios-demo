//
//  SNFormSectionElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
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
        
        for (NSDictionary* elementDict in [attributes objectForKey:@"elements"]) {
            for (NSDictionary* elementDict in [attributes objectForKey:@"elements"]) {
                
                if ([[elementDict objectForKey:@"type"] isEqualToString:@"Section"])
                {
                    SNFormSectionElement* section = [[SNFormSectionElement alloc] initWithAttributes:elementDict];
                    [self.elements addObject:section];
                    [section release];
                }
                else {
                    SNFormElement* element = [[SNFormElement alloc] initWithAttributes:elementDict];
                    [self.elements addObject:element];
                }
            }
        }
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
