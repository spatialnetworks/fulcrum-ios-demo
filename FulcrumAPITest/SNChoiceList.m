//
//  SNChoiceList.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceList.h"
#import "SNChoiceListItem.h"

@implementation SNChoiceList

@synthesize name = _name;
@synthesize choices = _choices;
@synthesize description = _description;
@synthesize id = _id;

- (id)init
{
    self = [super init];
    if (self) {
        self.choices = [NSMutableArray array];
    }
    return self;
}

- (id)initWithAttributes:(NSDictionary*)attributes
{
    self = [super init];
    if (self) {
        self.name = [attributes objectForKey:@"name"];
        self.choices = [attributes objectForKey:@"choices"];
        self.description = [attributes objectForKey:@"description"];
        self.id = [attributes objectForKey:@"id"];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* choiceAttributes = [NSMutableDictionary dictionary];
    
    if (self.name) [choiceAttributes setObject:self.name forKey:@"name"];
    if (self.description) [choiceAttributes setObject:self.description forKey:@"description"];
    if (self.id) [choiceAttributes setObject:self.id forKey:@"id"];
    
    NSMutableArray* choices = [NSMutableArray array];
    
    for (SNChoiceListItem* item in self.choices) {
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
    [_id release];
    
    [super dealloc];
}

@end
