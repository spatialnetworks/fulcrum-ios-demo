//
//  SNClassificationSetsViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNClassificationSetsViewController.h"
#import "SNClassificationSetAPI.h"

@interface SNClassificationSetsViewController ()

@property (nonatomic, retain) NSArray* classificationSets;
@property (nonatomic, retain) SSPullToRefreshView* pullToRefreshView;

@end

@implementation SNClassificationSetsViewController

@synthesize tableView = _tableView;
@synthesize classificationSets = _classificationSets;
@synthesize pullToRefreshView = _pullToRefreshView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Classification Sets";
        self.tabBarItem.title = @"Classification Sets";
        self.tabBarItem.image = [UIImage imageNamed:@"15-tags"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];
    
    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tappedAdd:)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    
    [self fetchClassificationSets];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    self.pullToRefreshView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) showClassificationSetEditView:(SNClassificationSet*)classificaitonSet
{
    SNClassificationSetEditViewController* editController = [[SNClassificationSetEditViewController alloc] initWithNibName:nil bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:editController];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    editController.delegate = self;
    
    if (classificaitonSet)
    {
        editController.classificationSet = classificaitonSet;
        editController.isAddMode = NO;
    }
    else {
        editController.isAddMode = YES;
    }
    
    [self presentModalViewController:nav animated:YES];
}

- (void) tappedAdd:(id)sender
{
    [self showClassificationSetEditView:nil];
}

- (void) classificationEditView:(SNClassificationSetEditViewController *)controller didFinishWithSave:(BOOL)saved
{
    [self dismissModalViewControllerAnimated:YES];
    
    if (saved)
    {
        if (controller.isAddMode)
        {
            [SNClassificationSetAPI createClassificationSet:controller.classificationSet 
                                      success:^(void){
                                          [self fetchClassificationSets];
                                      } 
                                      failure:^(NSError* error, NSArray* validationErrors) {
                                          [self showAlertMessageForError:error otherText:[NSString stringWithFormat:@"%@", validationErrors]];
                                      }];
        }
        else {
            [SNClassificationSetAPI updateClassificationSet:controller.classificationSet 
                                      success:^(void) {
                                          [self fetchClassificationSets];
                                      } 
                                      failure:^(NSError* error) {
                                          [self showAlertMessageForError:error otherText:@"Error updating choice list."];
                                      }];


        }
    }
}

- (void) showAlertMessageForError:(NSError*) error otherText:(NSString*)otherText
{
    UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                     message:[NSString stringWithFormat:@"Error creating Classification Set: %@", otherText] 
                                                    delegate:nil 
                                           cancelButtonTitle:@"Ok" 
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

#pragma mark -
#pragma mark SSPullToRefresh

- (void)refresh {
    [self.pullToRefreshView startLoading];
    // Load data...
    [self fetchClassificationSets];
    
    [self.pullToRefreshView finishLoading];
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
}

#pragma mark -
#pragma SNClassificationSetAPI

- (void) fetchClassificationSets
{
    
    [SNClassificationSetAPI getClassificationSetsSuccess:^(NSArray* classificationSets){
        self.classificationSets = classificationSets;
        [self.tableView reloadData];
    } 
        failure:^(NSError* error){
            [self showAlertMessageForError:error otherText:@"Error loading classification sets"];
        } ];
}

#pragma mark -
#pragma mark UITableView

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classificationSets.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    SNClassificationSet* classificaitonSet = [self.classificationSets objectAtIndex:indexPath.row];
    
    cell.textLabel.text = classificaitonSet.name;
    cell.detailTextLabel.text = classificaitonSet.description;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    SNClassificationSet* classificationSet = [self.classificationSets objectAtIndex:indexPath.row];
    [self showClassificationSetEditView:classificationSet];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        SNClassificationSet* set = [self.classificationSets objectAtIndex:indexPath.row];
        
        [SNClassificationSetAPI deleteClassificationSet:set
                                  success:^(void){
                                      [self fetchClassificationSets];
                                  } 
                                  failure:^(NSError* error) {
                                      [self showAlertMessageForError:error otherText:@"Error deleting classification set"];
                                  }];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_tableView release];
    [_classificationSets release];
    [_pullToRefreshView release];
    [super dealloc];
}
@end
