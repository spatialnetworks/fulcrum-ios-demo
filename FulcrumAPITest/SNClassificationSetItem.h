//
//  SNClassificationSetItem.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNClassificationSetItem : NSObject

- (NSMutableDictionary*) attributes;

@property (nonatomic, retain) NSString* label;
@property (nonatomic, retain) NSString* value;
@property (nonatomic, retain) NSMutableArray* childClassifications;

@end
