//
//  SNChoiceItem.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceItem.h"

@implementation SNChoiceItem

@synthesize label = _label;
@synthesize value = _value;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    if (self.label) [attributes setObject:self.label forKey:@"label"];
    if (self.value) [attributes setObject:self.value forKey:@"value"];
    
    return attributes;
}

- (void)dealloc
{
    [_label release];
    [_value release];
    
    [super dealloc];
}

@end
