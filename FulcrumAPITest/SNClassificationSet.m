//
//  SNClassificationSet.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNClassificationSet.h"
#import "SNClassificationSetItem.h"

@implementation SNClassificationSet

@synthesize name = _name;
@synthesize items = _items;
@synthesize label = _label;
@synthesize childClassificaitons = _childClassificaitons;
@synthesize value = _value;
@synthesize description = _description;
@synthesize id = _id;

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary*)attributes
{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:@"name"];
        self.items = [attributes objectForKey:@"items"];
        self.label = [attributes objectForKey:@"label"];
        self.childClassificaitons = [attributes objectForKey:@"child_classifications"];
        self.value = [attributes objectForKey:@"value"];
        self.description = [attributes objectForKey:@"description"];
        self.id = [attributes objectForKey:@"id"];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    if (self.name) [attributes setObject:self.name forKey:@"name"];
    if (self.label) [attributes setObject:self.label forKey:@"label"];
    if (self.description) [attributes setObject:self.description forKey:@"description"];
    if (self.value) [attributes setObject:self.value forKey:@"value"];
    if (self.id) [attributes setObject:self.id forKey:@"id"];
    
    NSMutableArray* itemAttributes = [NSMutableArray array];
    
    for (SNClassificationSetItem* item in self.items) {
        [itemAttributes addObject:item.attributes];
    }
    
    [attributes setObject:itemAttributes forKey:@"items"];
    
    return attributes;
}

- (void)dealloc
{
    [_name release];
    [_items release];
    [_label release];
    [_childClassificaitons release];
    [_value release];
    [_description release];
    [_id release];
    
    [super dealloc];
}

@end
