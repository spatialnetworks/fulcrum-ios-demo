//
//  SNChoiceList.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/29/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNChoiceList : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSMutableArray* choices;
@property (nonatomic, retain) NSString* description;

@end
