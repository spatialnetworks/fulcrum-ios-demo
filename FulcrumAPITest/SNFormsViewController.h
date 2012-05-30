//
//  SNFormsViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullToRefreshView.h"

@interface SNFormsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SSPullToRefreshViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
