//
//  SNClassificationSetItem.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNClassificationSetItem.h"

@implementation SNClassificationSetItem

@synthesize label = _label;
@synthesize value = _value;
@synthesize childClassifications = _childClassifications;

- (id)init
{
    self = [super init];
    if (self) {
        self.childClassifications = [NSMutableArray array];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary*)attributes
{
    self = [super init];
    if (self) {
        self.label = [attributes objectForKey:@"label"];
        self.value = [attributes objectForKey:@"value"];
        
        self.childClassifications = [attributes objectForKey:@"child_classifications"];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    if (self.label) [attributes setObject:self.label forKey:@"label"];
    if (self.value) [attributes setObject:self.value forKey:@"value"];
    
    NSMutableArray* childClassificationAttributes = [NSMutableArray array];
    if (self.childClassifications && [self.childClassifications count] > 0) {
        for (SNClassificationSetItem* item in self.childClassifications) {
            [childClassificationAttributes addObject:item.attributes];
        }
        
        [attributes setObject:childClassificationAttributes forKey:@"child_classifications"];
    }
    
    return attributes;
}

- (void)dealloc
{
    [_label release];
    [_value release];
    [_childClassifications release];
    
    [super dealloc];
}

@end
