//
//  SNChoiceList.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceList.h"
#import "SNChoiceItem.h"

@implementation SNChoiceList

@synthesize name = _name;
@synthesize choices = _choices;
@synthesize description = _description;

- (id)init
{
    self = [super init];
    if (self) {
        self.choices = [NSMutableArray array];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* choiceAttributes = [NSMutableDictionary dictionary];
    
    if (self.name) [choiceAttributes setObject:self.name forKey:@"name"];
    if (self.description) [choiceAttributes setObject:self.description forKey:@"description"];
    
    NSMutableArray* choices = [NSMutableArray array];
    
    for (SNChoiceItem* item in self.choices) {
        [choices addObject:item.attributes];
    }
    
    [choiceAttributes setObject:choices forKey:@"choices"];
    
    return choiceAttributes;
}

- (void)dealloc
{
    [_name release];
    [_choices release];
    [_description release];
    
    [super dealloc];
}

@end
