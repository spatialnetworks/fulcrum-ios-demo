//
//  SNChoiceListsViewController.m
//  FulcrumAPITest
//
//  Created by Ben Rigas on 5/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SNChoiceListsViewController.h"
#import "SNChoiceListAPI.h"

@interface SNChoiceListsViewController ()

@property (nonatomic, retain) NSArray* choiceLists;
@property (nonatomic, retain) SSPullToRefreshView* pullToRefreshView;

@end

@implementation SNChoiceListsViewController

@synthesize tableView = _tableView;
@synthesize choiceLists = _choiceLists;
@synthesize pullToRefreshView = _pullToRefreshView;

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
    self.pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:self.tableView delegate:self];

    [self fetchChoiceLists];
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    self.pullToRefreshView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark SSPullToRefresh

- (void)refresh {
    [self.pullToRefreshView startLoading];
    // Load data...
    [self fetchChoiceLists];
    
    [self.pullToRefreshView finishLoading];
}

- (void)pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
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
                                       UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" 
                                                                                        message:[NSString stringWithFormat:@"Error loading Choice Lists: %@", error] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
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

- (void)dealloc {
    [_tableView release];
    [_choiceLists release];
    [_pullToRefreshView release];
    
    [super dealloc];
}
@end
