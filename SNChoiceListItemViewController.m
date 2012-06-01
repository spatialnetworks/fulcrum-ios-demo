//
//  SNChoiceListItemViewController.m
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNChoiceListItemViewController.h"

@interface SNChoiceListItemViewController ()

@property (nonatomic, retain) UITextField* nameField;
@property (nonatomic, retain) UITextField* valueField;

@end

@implementation SNChoiceListItemViewController

@synthesize delegate = _delegate;
@synthesize nameField = _nameField;
@synthesize valueField = _valueField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _nameField = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 295, 34)];
        _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _nameField.delegate = self;
        _valueField = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 295, 34)];
        _valueField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _valueField.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tappedSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tappedCancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];

    [self.nameField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.nameField = nil;
    self.valueField = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) tappedSave:(id)sender
{
    SNChoiceListItem* item = [[SNChoiceListItem alloc] init];
    item.label = self.nameField.text;
    item.value = self.valueField.text;
    [self.delegate choiceListItemController:self didFinishWithItem:item];
    [item release];
}

- (void) tappedCancel:(id)sender
{
    [self.delegate choiceListItemController:self didFinishWithItem:nil];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    switch (indexPath.row) {
        case 0:
            [cell addSubview:self.nameField];
            cell.textLabel.text = @"Label";
            break;
        case 1:
            [cell addSubview:self.valueField];
            cell.textLabel.text = @"Value";
            break;
        default:
            break;
    }

    return cell;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    
}

@end
