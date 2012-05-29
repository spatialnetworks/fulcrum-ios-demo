//
//  SNClassificationSet.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNClassificationSet : NSObject

- (NSMutableDictionary*) attributes;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSMutableArray* items;
@property (nonatomic, retain) NSString* label;
@property (nonatomic, retain) NSMutableArray* childClassificaitons;
@property (nonatomic, retain) NSString* value;
@property (nonatomic, retain) NSString* description;

@end
