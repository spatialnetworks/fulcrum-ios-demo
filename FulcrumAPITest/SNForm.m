//
//  SNForm.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNForm.h"
#import "SNFormSectionElement.h"

@implementation SNForm

@synthesize name = _name;
@synthesize description = _description;
@synthesize id = _id;
@synthesize updatedAt = _updatedAt;
@synthesize createdAt = _createdAt;
@synthesize elements = _elements;

- (id)initWithAttributes:(NSDictionary*)attributes
{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:@"name"];
        self.description = [attributes objectForKey:@"description"];
        self.id = [attributes objectForKey:@"id"];
        self.createdAt = [attributes objectForKey:@"created_at"];
        self.updatedAt = [attributes objectForKey:@"updated_at"];
        self.elements = [NSMutableArray array];
        
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
        
        NSLog(@"attributes: %@", attributes);
    }
    
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.elements = [NSMutableArray array];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    if (self.name) [attributes setObject:self.name forKey:@"name"];
    if (self.description) [attributes setObject:self.description forKey:@"description"];
    if (self.id) [attributes setObject:self.id forKey:@"id"];
//    if (self.createdAt) [attributes setObject:self.createdAt forKey:@"created_at"];
//    if (self.updatedAt) [attributes setObject:self.updatedAt forKey:@"updated_at"];
    
    NSMutableArray* elements = [NSMutableArray array];
    for (SNFormElement* element in self.elements) {
        [elements addObject:element.attributes];
    }
    [attributes setObject:elements forKey:@"elements"];
    NSMutableDictionary* baseAttribute = [NSMutableDictionary dictionary];
    [baseAttribute setObject:attributes forKey:@"form"];
    
    return baseAttribute;
}

- (void)dealloc
{
    [_name release];
    [_description release];
    [_id release];
    [_updatedAt release];
    [_createdAt release];
    
    [super dealloc];
}

@end
