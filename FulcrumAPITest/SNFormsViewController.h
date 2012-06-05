//
//  SNFormsViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNFormViewController.h"

@interface SNFormsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SNFormViewControllerDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
