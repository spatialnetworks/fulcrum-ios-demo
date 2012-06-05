//
//  SNFormViewController.h
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/5/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SNForm.h"

@interface SNFormViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) id delegate;
@property (nonatomic, retain) SNForm* form;

@end

@protocol SNFormViewControllerDelegate <NSObject>

- (void) formViewController:(SNFormViewController*)controller didFinishWithSave:(BOOL)saved;

@end
