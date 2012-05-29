//
//  SNForm.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNFormElement.h"
#import "SNFormSectionElement.h"

@interface SNForm : NSObject

- (id)initWithAttributes:(NSDictionary*)dictionary;
- (NSMutableDictionary*) attributes;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* description;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSDate* updatedAt;
@property (nonatomic, retain) NSDate* createdAt;

@property (nonatomic, retain) SNFormSectionElement* rootSectionElement;

@end
