//
//  SNChoiceListsViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNChoiceListsViewController.h"
#import "SNChoiceListAPI.h"

@interface SNChoiceListsViewController ()

@property (nonatomic, retain) NSArray* choiceLists;

@end

@implementation SNChoiceListsViewController

@synthesize tableView = _tableView;
@synthesize choiceLists = _choiceLists;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Choice Lists";
        self.tabBarItem.title = @"Choice lists";
        self.tabBarItem.image = [UIImage imageNamed:@"259-list"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    UIBarButtonItem* addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tappedAdd:)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem* refreshButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(tappedRefresh:)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    [refreshButton release];
    
    [self fetchChoiceLists];
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

- (void) showChoiceListEditView:(SNChoiceList*)choiceList
{
    SNChoiceListEditViewController* choiceController = [[[SNChoiceListEditViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    choiceController.delegate = self;
    if (choiceList)
    {
        choiceController.choiceList = choiceList;
        choiceController.isAddMode = NO;
    }
    else {
        choiceController.isAddMode = YES;
    }
    UINavigationController* nav = [[[UINavigationController alloc] initWithRootViewController:choiceController] autorelease];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [self presentModalViewController:nav animated:YES];    
}

- (void) tappedAdd:(id)sender
{
    [self showChoiceListEditView:nil];
}

- (void) tappedRefresh:(id)sender
{
    [self refresh];
}

- (void) choiceListEditor:(SNChoiceListEditViewController *)editController didFinishWithSave:(BOOL)saved
{
    [self dismissModalViewControllerAnimated:YES];

    if (saved)
    {
        if (editController.isAddMode)
        {
            [SNChoiceListAPI createChoiceList:editController.choiceList 
                                      success:^(void){
                                          [self fetchChoiceLists];
                                      } 
                                      failure:^(NSError* error, NSArray* validationErrors) {
                                          [self showAlertMessageForError:error otherText:[NSString stringWithFormat:@"%@", validationErrors]];
                                      }];
        }
        else {
            [SNChoiceListAPI updateChoiceList:editController.choiceList 
                                      success:^(void) {
                                          [self fetchChoiceLists];
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
                                                     message:[NSString stringWithFormat:@"Error: %@", otherText] 
                                                    delegate:nil 
                                           cancelButtonTitle:@"Ok" 
                                           otherButtonTitles:nil] autorelease];
    [alert show];
}

- (void)refresh {
    // Load data...
    [self fetchChoiceLists];    
}

#pragma mark -
#pragma mark SNChoiceListAPI

- (void) fetchChoiceLists
{
    [SNChoiceListAPI getChoiceListsSuccess:^(NSArray* choiceLists) {
        self.choiceLists = choiceLists;
        [self.tableView reloadData];
    }
                                   failure:^(NSError* error) {
                                       [self showAlertMessageForError:error otherText:@"Error fetching choice lists"];
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
    return self.choiceLists.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString* cellID = @"cell";
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID] autorelease];
    }
    
    SNChoiceList* choiceList = [self.choiceLists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = choiceList.name;
    cell.detailTextLabel.text = choiceList.description;
    
    return cell;
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        SNChoiceList* choiceList = [self.choiceLists objectAtIndex:indexPath.row];
        
        [SNChoiceListAPI deleteChoiceList:choiceList 
                                  success:^(void){
                                      [self fetchChoiceLists];
                                  } 
                                  failure:^(NSError* error) {
                                      [self showAlertMessageForError:error otherText:@"Error loading choice lists"];
                                  }];
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SNChoiceList* choiceList = [self.choiceLists objectAtIndex:indexPath.row];
    [self showChoiceListEditView:choiceList];
}

- (void)dealloc {
    [_tableView release];
    [_choiceLists release];
    
    [super dealloc];
}
@end
