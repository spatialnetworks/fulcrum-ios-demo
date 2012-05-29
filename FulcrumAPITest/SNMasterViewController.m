//
//  SNMasterViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/25/12.
//  Copyright (c) 2012 Spatial Networks. All rights reserved.
//

#import "SNMasterViewController.h"

#import "SNDetailViewController.h"

#import "SNFormAPI.h"
#import "SNFormSectionElement.h"
#import "SNFormTextFieldElement.h"
#import "SNFormChoiceFieldElement.h"
#import "SNClassificationSet.h"
#import "SNClassificationSetItem.h"

@interface SNMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation SNMasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.clearsSelectionOnViewWillAppear = NO;
            self.contentSizeForViewInPopover = CGSizeMake(320.0, 600.0);
        }
    }
    return self;
}
							
- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;

//    [self getForms];
//    [self createTestForm];
    [self createClassificationSet];
}

- (void) getForms
{    
    [SNFormAPI getFormsWithSchema:YES 
                      success:^(NSArray* myForms) {
//                          NSLog(@"form0: %@", [forms objectAtIndex:1]);
                          for (NSDictionary* form in myForms) {
                              NSLog(@"form %@", form);
                          }
                      } 
                      failure:^(NSError* error) {
                          NSLog(@"dang: %@", error);
                      }];    
}

- (void) createTestForm
{
    SNForm* testForm = [[SNForm alloc] init];
    
    testForm.name = @"Test API Form";
    testForm.description = @"Form made from API";
        
    for (int x = 0; x < 10; x++) {
        SNFormTextFieldElement* textElement = [[SNFormTextFieldElement alloc] init];
        textElement.label = [NSString stringWithFormat:@"Text field #%d", x];
        textElement.dataName = @"text_foo";
        [testForm.rootSectionElement.elements addObject:textElement];
        [textElement release];
    }
    
    SNFormChoiceFieldElement* choiceElement = [[SNFormChoiceFieldElement alloc] init];
    choiceElement.multiple = NO;
    choiceElement.allowOther = NO;
    choiceElement.dataName = @"test_choice";
    choiceElement.label = @"Test Choice, no Multiple, no Other";
    [choiceElement addLabel:@"A" withValue:@"A"];
    [choiceElement addLabel:@"B" withValue:@"B"];
    [choiceElement addLabel:@"C" withValue:@"C"];
    [testForm.rootSectionElement.elements addObject:choiceElement];
    [choiceElement release];
    
    choiceElement = [[SNFormChoiceFieldElement alloc] init];
    choiceElement.multiple = YES;
    choiceElement.allowOther = NO;
    choiceElement.dataName = @"test_choice";
    choiceElement.label = @"Test Choice, with Multiple, no Other";
    [choiceElement addLabel:@"A" withValue:@"A"];
    [choiceElement addLabel:@"B" withValue:@"B"];
    [choiceElement addLabel:@"C" withValue:@"C"];
    [testForm.rootSectionElement.elements addObject:choiceElement];
    [choiceElement release];
    
    choiceElement = [[SNFormChoiceFieldElement alloc] init];
    choiceElement.multiple = YES;
    choiceElement.allowOther = YES;
    choiceElement.dataName = @"test_choice";
    choiceElement.label = @"Test Choice, with Multiple, With Other";
    [choiceElement addLabel:@"A" withValue:@"A"];
    [choiceElement addLabel:@"B" withValue:@"B"];
    [choiceElement addLabel:@"C" withValue:@"C"];
    [testForm.rootSectionElement.elements addObject:choiceElement];
    [choiceElement release];
    
    choiceElement = [[SNFormChoiceFieldElement alloc] init];
    choiceElement.multiple = NO;
    choiceElement.allowOther = YES;
    choiceElement.dataName = @"test_choice";
    choiceElement.label = @"Test Choice, no Multiple, with Other";
    [choiceElement addLabel:@"A" withValue:@"A"];
    [choiceElement addLabel:@"B" withValue:@"B"];
    [choiceElement addLabel:@"C" withValue:@"C"];
    [testForm.rootSectionElement.elements addObject:choiceElement];
    [choiceElement release];
    
    SNFormSectionElement* testSection = [[SNFormSectionElement alloc] init];
    testSection.label = @"Some section";
    testSection.dataName = @"test_sec";
    
    for (int x = 0; x < 5; x++) {
        SNFormTextFieldElement* textElement = [[SNFormTextFieldElement alloc] init];
        textElement.label = [NSString stringWithFormat:@"Section Text field #%d", x];
        textElement.dataName = @"text_foo";
        [testSection.elements addObject:textElement];
        [textElement release];
    }
    
    [testForm.rootSectionElement.elements addObject:testSection];
    
    [SNFormAPI createForm:testForm 
              success:^(void){
                  NSLog(@"Form created!");
              } 
              failure:^(NSError* error, NSArray* validationErrors){
                  NSLog(@"Dang: %@ ... %@", error, validationErrors);
              }
     ];    
}

- (void) createClassificationSet
{
    SNClassificationSet* classificationSet = [[SNClassificationSet alloc] init];
    
    classificationSet.name = @"Classy";
    classificationSet.label = @"Wat?";
    classificationSet.description = @"Classify";
    
    for (int x = 0; x < 10; x++) {
        SNClassificationSetItem* item = [[SNClassificationSetItem alloc] init];
        item.label = [NSString stringWithFormat:@"label %d", x];
        item.value = [NSString stringWithFormat:@"value %d", x];
        [classificationSet.items addObject:item];
        [item release];
    }
    
    SNClassificationSetItem* nestedItem = [[SNClassificationSetItem alloc] init];
    
    nestedItem.label = @"Testing";
    nestedItem.value = @"Testing";
    
    for (int x = 0; x < 4; x++) {
        SNClassificationSetItem* item = [[SNClassificationSetItem alloc] init];
        item.label = [NSString stringWithFormat:@"label %d", x];
        item.value = [NSString stringWithFormat:@"value %d", x];
        [nestedItem.childClassifications addObject:item];
        [item release];
    }
    
    [classificationSet.items addObject:nestedItem];
    
    [nestedItem release];
    
    NSLog(@"CS: %@", classificationSet.attributes);
    
    [classificationSet release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)insertNewObject:(id)sender
{
    if (!_objects) {
        _objects = [[NSMutableArray alloc] init];
    }
    [_objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }


    NSDate *object = [_objects objectAtIndex:indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [_objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDate *object = [_objects objectAtIndex:indexPath.row];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
	    if (!self.detailViewController) {
	        self.detailViewController = [[[SNDetailViewController alloc] initWithNibName:@"SNDetailViewController_iPhone" bundle:nil] autorelease];
	    }
	    self.detailViewController.detailItem = object;
        [self.navigationController pushViewController:self.detailViewController animated:YES];
    } else {
        self.detailViewController.detailItem = object;
    }
}

@end
