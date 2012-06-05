//
//  SNFormViewController.m
//  FulcrumAPIDemo
//
//  Created by Ben Rigas on 6/5/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFormViewController.h"
#import "SNFormSectionViewController.h"

@interface SNFormViewController ()

@end

@implementation SNFormViewController

@synthesize tableView = _tableView;
@synthesize delegate = _delegate;
@synthesize form = _form;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(tappedCancel:)];
        self.navigationItem.leftBarButtonItem = cancelButton;
        [cancelButton release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = self.form.name;
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
    [_form release];
    
    [super dealloc];
}

- (void) tappedCancel:(id)sender
{
    [self.delegate formViewController:self didFinishWithSave:NO];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.form.elements.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID] autorelease];
    }
    
    SNFormElement* element = [self.form.elements objectAtIndex:indexPath.row];
    cell.textLabel.text = element.label;
    cell.detailTextLabel.text = element.type;
 
    if ([element.type isEqualToString:@"Section"])
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNFormElement* element = [self.form.elements objectAtIndex:indexPath.row];
    
    if ([element.type isEqualToString:@"Section"])
    {
        SNFormSectionViewController* sectionController = [[SNFormSectionViewController alloc] initWithNibName:nil bundle:nil];
        sectionController.formSection = (SNFormSectionElement*)element;
        [self.navigationController pushViewController:sectionController animated:YES];
        [sectionController release];
    }
}

@end
