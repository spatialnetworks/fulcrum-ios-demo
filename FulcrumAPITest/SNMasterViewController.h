//
//  SNMasterViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SNDetailViewController;

@interface SNMasterViewController : UITableViewController

@property (strong, nonatomic) SNDetailViewController *detailViewController;

@end
