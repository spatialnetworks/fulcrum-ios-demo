//
//  SNChoiceListItemViewController.h
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNChoiceListItem.h"

@interface SNChoiceListItemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (nonatomic, assign) id delegate;

@end

@protocol SNChoiceListItemViewControllerDelegate <NSObject>

- (void) choiceListItemController:(SNChoiceListItemViewController*)controller didFinishWithItem:(SNChoiceListItem*)item;

@end
