//
//  SNClassificationSetEditViewController.h
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNClassificationSet.h"

@interface SNClassificationSetEditViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) SNClassificationSet* classificationSet;
@property BOOL isAddMode;

@end

@protocol SNClassificationSetEditViewControllerDelegate <NSObject>

- (void) classificationEditView:(SNClassificationSetEditViewController*)controller didFinishWithSave:(BOOL)saved;

@end