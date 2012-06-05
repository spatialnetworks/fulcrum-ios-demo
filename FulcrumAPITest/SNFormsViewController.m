//
//  SNFormsViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNFormsViewController.h"

#import "SNFormAPI.h"

@interface SNFormsViewController ()

@property (nonatomic, retain) NSArray* forms;

@end

@implementation SNFormsViewController
@synthesize tableView = _tableView;
@synthesize forms = _forms;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Forms";
        self.tabBarItem.title = @"Forms";
        self.tabBarItem.image = [UIImage imageNamed:@"255-box"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
        
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(tappedRefresh:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    [refreshButton release];
    
    [self fetchForms];
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

- (void) tappedRefresh:(id)sender
{
    [self refresh];
}

- (void)refresh {
    // Load data...
    [self fetchForms];
}

#pragma mark -
#pragma mark SNFormAPI

- (void) fetchForms
{
    [SNFormAPI getFormsWithSchema:YES 
                          success:^(NSArray* forms) {
                              self.forms = forms;
                              [self.tableView reloadData];
                          } 
                          failure:^(NSError* error) {
                              UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                                               message:[NSString stringWithFormat:@"Error loading Forms: %@", error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
                              [alert show];
                          }];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.forms.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    SNForm* form = [self.forms objectAtIndex:indexPath.row];
    
    cell.textLabel.text = form.name;
    cell.detailTextLabel.text = form.description;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SNFormViewController* formController = [[SNFormViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:formController];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    
    SNForm* form = [self.forms objectAtIndex:indexPath.row];
    formController.form = form;
    formController.delegate = self;
    
    [self presentModalViewController:nav animated:YES];
    
    [nav release];
    [formController release];
}

- (void) formViewController:(SNFormViewController *)controller didFinishWithSave:(BOOL)saved
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    [_tableView release];
    [_forms release];
    [super dealloc];
}

@end
