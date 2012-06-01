//
//  SNChoiceItem.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNChoiceListItem : NSObject

- (NSMutableDictionary*) attributes;
- (id)initWithAttributes:(NSDictionary*)attributes;

@property (nonatomic, retain) NSString* label;
@property (nonatomic, retain) NSString* value;

@end
