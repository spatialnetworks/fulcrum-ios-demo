//
//  SNChoiceListsViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSPullToRefreshView.h"
#import "SNChoiceListEditViewController.h"

@interface SNChoiceListsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SSPullToRefreshViewDelegate, SNChoiceListEditViewControllerDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
