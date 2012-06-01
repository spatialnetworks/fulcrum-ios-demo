//
//  SNClassificationSetEditViewController.m
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNClassificationSetEditViewController.h"
#import "SNClassificationSetItem.h"

@interface SNClassificationSetEditViewController ()

@property (nonatomic, retain) UITableViewCell* nameCell;

@end

@implementation SNClassificationSetEditViewController

@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize classificationSet = _classificationSet;
@synthesize isAddMode = _isAddMode;
@synthesize nameCell = _nameCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Classification Set";
    
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_tableView release];
    [_classificationSet release];
    [super dealloc];
}

- (void) tappedSave:(id)sender
{
    [self.delegate classificationEditView:self didFinishWithSave:YES];
}

- (void) tappedCancel:(id)sender
{
    [self.delegate classificationEditView:self didFinishWithSave:NO];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger numberOfRows = 0;
    
    switch (section) {
        case 0:
            numberOfRows = 1;
            break;
        case 1:
            numberOfRows = self.classificationSet.childClassificaitons.count +1;
        default:
            break;
    }
    
    return numberOfRows;
}

- (UITableViewCell*) nameCell
{
    if (_nameCell == nil)
    {
        _nameCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"name"];
        
        UITextField* nameField = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, 295, 34)];
        nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        nameField.tag = 1;
        nameField.delegate = self;
        nameField.placeholder = @"Name";
        
        nameField.text = self.classificationSet.name;

        [_nameCell.contentView addSubview:nameField];
        [nameField release];
    }
    
    return _nameCell;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    UITableViewCell* cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = self.nameCell;
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (cell == nil)
            {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            }
            
            if (indexPath.row == self.classificationSet.childClassificaitons.count)
            {
                cell.textLabel.text = @"+ Add Classification";
            }
            
            SNClassificationSetItem* set = [self.classificationSet.childClassificaitons objectAtIndex:indexPath.row];
            cell.textLabel.text = set.label;
            
            break;
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
            title = @"Classification Set Name";
            break;
        case 1:
            title = @"Classifications";
            break;
        default:
            break;
    }
    
    return title;
}

@end
