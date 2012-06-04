//
//  SNClassificationSetItemEditViewController.h
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNClassificationSetItem.h"

@interface SNClassificationSetItemEditViewController : UIViewController <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id delegate;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SNClassificationSetItem* classificationItem;

@end

@protocol SNClassificationSetItemEditViewControllerDelegate <NSObject>

- (void) classificationItem:(SNClassificationSetItemEditViewController*)item didFinishWithSave:(BOOL)saved;

@end
