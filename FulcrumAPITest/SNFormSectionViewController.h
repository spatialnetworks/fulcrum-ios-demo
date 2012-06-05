//
//  SNFormSectionViewController.h
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/5/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNFormSectionElement.h"

@interface SNFormSectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) SNFormSectionElement* formSection;

@end
