//
//  SNChoiceFieldElement.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFormElement.h"

@interface SNFormChoiceFieldElement : SNFormElement

- (void) addLabel:(NSString*)label withValue:(NSString*)value;

@property BOOL multiple;
@property BOOL allowOther;
@property (nonatomic, retain) NSString* choiceListID;
@property (nonatomic, retain) NSMutableArray* choices;

@end
