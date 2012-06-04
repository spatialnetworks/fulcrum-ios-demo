//
//  SNChoiceListEditViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/31/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceListEditViewController.h"

@interface SNChoiceListEditViewController ()

@property (nonatomic, retain) UITableViewCell* labelCell;
@property (nonatomic, retain) UITableViewCell* addButtonCell;

@end

@implementation SNChoiceListEditViewController

@synthesize delegate = _delegate;
@synthesize tableView = _tableView;
@synthesize labelCell = _labelCell;
@synthesize addButtonCell = _addButtonCell;
@synthesize choiceList = _choiceList;
@synthesize isAddMode = _isAddMode;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Choice List";
    
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(tappedSave:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton release];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tappedCancel:)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    [cancelButton release];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) tappedSave:(id)sender
{
    [self.delegate choiceListEditor:self didFinishWithSave:YES];
}

- (void) tappedCancel:(id)sender
{
    [self.delegate choiceListEditor:self didFinishWithSave:NO];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfSections = 0;
    
    switch (section) {
        case 0:
            numberOfSections = 1;
            break;
        case 1:
            numberOfSections = self.choiceList.choices.count + 1;
            break;
        default:
            break;
    }
    
    return numberOfSections;
}

- (UITableViewCell*) labelCell
{
    if (_labelCell == nil)
    {
        _labelCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"label"];
        
        UITextField* nameField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 290, 34)];
        nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nameField.tag = 1;
        nameField.delegate = self;
        nameField.placeholder = @"Name";
        nameField.text = self.choiceList.name;
        
        [_labelCell.contentView addSubview:nameField];
        [nameField release];
    }
    
    return _labelCell;
}

- (UITableViewCell*) addButtonCell
{
    if (_addButtonCell == nil)
    {
        _addButtonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add"];
        _addButtonCell.textLabel.text = @"Add new choice";
    }
    
    return _addButtonCell;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    UITableViewCell* cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = self.labelCell;
            break;
        case 1:
            if (indexPath.row == self.choiceList.choices.count)
            {
                cell = self.addButtonCell;
            } else {
                cell = [tableView dequeueReusableCellWithIdentifier:cellID];
                
                if (cell == nil)
                {
                    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
                }
                
                cell.textLabel.text = [[self.choiceList.choices objectAtIndex:indexPath.row] label];
            }
        
        default:
            break;
    }
        
    return cell;
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString* title = @"";
    
    switch (section) {
        case 0:
            title = @"Choice List Name";
            break;
        case 1:
            title = @"Choices";
            break;
        default:
            break;
    }
    
    return title;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 1 && indexPath.row == self.choiceList.choices.count)
    {
        SNChoiceListItemViewController* itemController = [[SNChoiceListItemViewController alloc] initWithNibName:nil bundle:nil];
        itemController.delegate = self;
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:itemController];
        nav.navigationBar.barStyle = UIBarStyleBlack;
        [self presentModalViewController:nav animated:YES];
        [itemController release];
        [nav release];
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self.choiceList.choices removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL canEdit = NO;
    
    if (indexPath.section == 1 && indexPath.row != self.choiceList.choices.count)
    {
        canEdit = YES;
    }
    
    return canEdit;
}

- (void) choiceListItemController:(SNChoiceListItemViewController *)controller didFinishWithItem:(SNChoiceListItem *)item
{
    if (item)
    {
        [self.choiceList.choices addObject:item];
        [self.tableView reloadData];
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (SNChoiceList*) choiceList
{
    if (_choiceList == nil)
    {
        _choiceList = [[SNChoiceList alloc] init];
    }
    
    return _choiceList;
}

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 1)
    {
        self.choiceList.name = textField.text;
    }
}

- (void)dealloc {
    [_tableView release];
    [_labelCell release];
    [_addButtonCell release];
    [super dealloc];
}
@end
