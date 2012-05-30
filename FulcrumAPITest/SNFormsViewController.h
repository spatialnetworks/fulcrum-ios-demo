//
//  SNFormsViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNFormsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
