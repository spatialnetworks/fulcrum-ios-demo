//
//  SNChoiceFieldElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNFormChoiceFieldElement.h"

@implementation SNFormChoiceFieldElement

@synthesize multiple = _multiple;
@synthesize allowOther = _allowOther;
@synthesize choiceListID = _choiceListID;
@synthesize choices = _choices;

- (id)init
{
    self = [super init];
    if (self) {
        self.type = @"ChoiceField";
        self.choices = [NSMutableArray array];
    }
    return self;
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [super attributes];
    
    [attributes setObject:[NSNumber numberWithBool:self.multiple] forKey:@"multiple"];
    [attributes setObject:[NSNumber numberWithBool:self.allowOther] forKey:@"allow_other"];
    
    if (self.choiceListID) {
        [attributes setObject:self.choiceListID forKey:@"choice_list_id"];
    } else {
        [attributes setObject:self.choices forKey:@"choices"];
    }
    
    return attributes;
}


- (void) addLabel:(NSString*)label withValue:(NSString*)value
{
    NSMutableDictionary* choice = [NSMutableDictionary dictionary];
    
    [choice setObject:label forKey:@"label"];
    [choice setObject:value forKey:@"value"];
    
    [self.choices addObject:choice];
}

- (void)dealloc
{
    [_choiceListID release];
    [_choices release];
    
    [super dealloc];
}

@end
