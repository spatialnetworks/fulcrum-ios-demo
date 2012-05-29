//
//  SNFormElement.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNFormElement.h"

/*
 "disabled":false,
 "hidden":false,
 "key":"b8fbca33-cad6-1eb5-b4ec-d78cf8aa9323",
 "type":"Section",
 "data_name":"park_report",
 "required":false,
 "label":"Park Report",
 */

@implementation SNFormElement

@synthesize disabled = _disabled;
@synthesize hidden = _hidden;
@synthesize key = _key;
@synthesize type = _type;
@synthesize dataName = _dataName;
@synthesize required = _required;
@synthesize label = _label;


- (id)initWithAttributes:(NSMutableDictionary*)attributes
{
    self = [super init];
    if (self) {
        self.disabled = [[attributes objectForKey:@"disabled"] boolValue];
        self.hidden = [[attributes objectForKey:@"hidden"] boolValue];
        self.key = [attributes objectForKey:@"key"];
        self.type = [attributes objectForKey:@"type"];
        self.dataName = [attributes objectForKey:@"data_name"];
        self.required = [[attributes objectForKey:@"required"] boolValue];
        self.label = [attributes objectForKey:@"label"];
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.key = [SNFormElement generateKey];
        self.hidden = NO;
        self.disabled = NO;
        self.required = NO;
        self.dataName = @"";
        self.label = @"";
        self.type = @"";
    }
    return self;
}

+ (NSString*) generateKey
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return [(NSString *)string autorelease];
}

- (NSMutableDictionary*) attributes
{
    NSMutableDictionary* attributes = [NSMutableDictionary dictionary];
    
    [attributes setObject:[NSNumber numberWithBool:self.disabled] forKey:@"disabled"];
    [attributes setObject:[NSNumber numberWithBool:self.hidden] forKey:@"hidden"];

    
    if (self.key) [attributes setObject:self.key forKey:@"key"];
    if (self.type) [attributes setObject:self.type forKey:@"type"];
    if (self.dataName) [attributes setObject:self.dataName forKey:@"data_name"];
    [attributes setObject:[NSNumber numberWithBool:self.required] forKey:@"required"];
    if (self.label) [attributes setObject:self.label forKey:@"label"];
    
    return attributes;
}

- (void)dealloc
{
    [_key release];
    [_type release];
    [_dataName release];
    [_label release];
    
    [super dealloc];
}

@end
