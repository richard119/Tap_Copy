//
//  RZLViewController.m
//  CB_tableview1
//
//  Created by 凌 钟 on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


#define SYSBARBUTTON(ITEM, SELECTOR) [[UIBarButtonItem alloc] initWithBarButtonSystemItem:ITEM target:self action:SELECTOR]

#import "RZLViewController.h"

@interface RZLViewController ()

@end

@implementation RZLViewController

@synthesize list = _list;  

- (void)viewDidLoad
{
      [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
/*    NSArray *array = [[NSArray alloc] initWithObjects:@"美国", @"菲律宾",  
                      @"黄岩岛", @"中国", @"泰国", @"越南", @"老挝",  
                      @"日本" , nil];  */
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RZLp1" ofType:@"plist"];
    
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:plistPath]; 
    self.list = array; 
    
//    self.navigationItem.rightBarButtonItem =[[UIBarButtonItem alloc] 
//                            initWithTitle:@"Edit" 
//                            style:UIBarButtonItemStyleBordered 
//                            target:self 
//                            action:@selector(toggleMove)]; 
//
//    self.navigationItem.leftBarButtonItem = SYSBARBUTTON(UIBarButtonSystemItemAdd, @selector(addItem:));
  
    
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)section 
{
	// Return the number of items
	return self.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier"; 
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: 
                             TableSampleIdentifier]; 
    if (cell == nil) { 
        cell = [[UITableViewCell alloc] 
                initWithStyle:UITableViewCellStyleDefault 
                reuseIdentifier:TableSampleIdentifier]; 
    } 
    
    NSUInteger row = [indexPath row]; 
    cell.textLabel.text = [self.list objectAtIndex:row]; 
	return cell; 
}


-(IBAction)toggleMove
{ 
     [self.tableView setEditing:!self.tableView.editing animated:YES];
    
    if (self.tableView.editing)
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
    }
    else
    {
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
        
         NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RZLp1" ofType:@"plist"];
        [self.list writeToFile:plistPath atomically:YES];
    }
    
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    [self.list removeObjectAtIndex:row];
    [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                     withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RZLp1" ofType:@"plist"];
    [self.list writeToFile:plistPath atomically:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView
canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
    NSUInteger fromRow = [fromIndexPath row];
    NSUInteger toRow = [toIndexPath row];
    
    id object = [self.list objectAtIndex:fromRow];
    [self.list removeObjectAtIndex:fromRow];
    [self.list insertObject:object atIndex:toRow];
}


- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath { 
    
    NSUInteger row = [indexPath row];
    NSString *rowTitle = [self.list objectAtIndex:row]; 
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"You tapped the row." 
                          message:[NSString stringWithFormat:@"%@ have been copied.", rowTitle]delegate:nil                                               
                          cancelButtonTitle:@"OK" 
                          otherButtonTitles:nil];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = rowTitle;
    
    [alert show];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) applicationWillResignActive:(NSNotification *)notification{

}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    self.list = nil; 
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"Add"])
	{
		UINavigationController *navigationController = 
        segue.destinationViewController;
		RZLNewItemCtrl  
        *RZLNewItemCtrl1 = 
        [[navigationController viewControllers] 
         objectAtIndex:0];
		RZLNewItemCtrl1.delegate = self;
	}
}

#pragma mark - PlayerDetailsViewControllerDelegate

- (void)RZLNewItemCtrlDelegateDidCancel:
(RZLNewItemCtrl *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)RZLNewItemCtrl:(RZLNewItemCtrl *)controller
            DidAddItem:(NSString *) stritem
{
    [self.list addObject:stritem];
	NSIndexPath *indexPath = 
    [NSIndexPath indexPathForRow:[self.list count] - 1 
                       inSection:0];
    
	[self.tableView insertRowsAtIndexPaths:
     [NSArray arrayWithObject:indexPath] 
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"RZLp1" ofType:@"plist"];
    [self.list writeToFile:plistPath atomically:YES];

	[self dismissViewControllerAnimated:YES completion:nil];
}


@end
