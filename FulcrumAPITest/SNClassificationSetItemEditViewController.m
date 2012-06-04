//
//  SNClassificationSetItemEditViewController.m
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNClassificationSetItemEditViewController.h"

@interface SNClassificationSetItemEditViewController ()

@property (nonatomic, retain) UITextField* labelField;
@property (nonatomic, retain) UITextField* valueField;

@end

@implementation SNClassificationSetItemEditViewController

@synthesize tableView = _tableView;
@synthesize labelField = _labelField;
@synthesize valueField = _valueField;
@synthesize delegate = _delegate;
@synthesize classificationItem = _classificationItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _labelField = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 295, 34)];
        _labelField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _labelField.delegate = self;
        _valueField = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 295, 34)];
        _valueField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _valueField.delegate = self;
        
        _classificationItem = [[SNClassificationSetItem alloc] init];
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
    
    [self.labelField becomeFirstResponder];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_tableView release];
    [_labelField release];
    [_valueField release];
    [_classificationItem release];
    
    [super dealloc];
}

- (void) tappedSave:(id)sender
{    
    [self.delegate classificationItem:self didFinishWithSave:YES];
}

- (void) tappedCancel:(id)sender
{
    [self.delegate classificationItem:self didFinishWithSave:NO];
}

#pragma mark -
#pragma mark UITextField

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.labelField)
    {
        self.classificationItem.label = self.labelField.text;
    }
    else if (textField == self.valueField) {
        self.classificationItem.value = self.valueField.text;
    }
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
            [cell addSubview:self.labelField];
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

@end
