//
//  SNChoiceListEditViewController.h
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/31/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNChoiceListItemViewController.h"
#import "SNChoiceList.h"

@interface SNChoiceListEditViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, SNChoiceListItemViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, assign) id delegate;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) SNChoiceList* choiceList;
@property BOOL isAddMode;

@end

@protocol SNChoiceListEditViewControllerDelegate <NSObject>

- (void) choiceListEditor:(SNChoiceListEditViewController*)editController didFinishWithSave:(BOOL)saved;

@end