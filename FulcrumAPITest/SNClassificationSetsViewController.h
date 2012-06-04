//
//  SNClassificationSetsViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullToRefreshView.h"
#import "SNClassificationSetEditViewController.h"

@interface SNClassificationSetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SSPullToRefreshViewDelegate, SNClassificationSetEditViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
