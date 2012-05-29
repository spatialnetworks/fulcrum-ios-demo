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

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
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
    
    [super dealloc];
}

@end
