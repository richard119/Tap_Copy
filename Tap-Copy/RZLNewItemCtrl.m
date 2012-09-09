//
//  RZLNewItemCtrl.m
//  CB_tableview1
//
//  Created by 凌 钟 on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RZLNewItemCtrl.h"

@interface RZLNewItemCtrl ()

@end


@implementation RZLNewItemCtrl

@synthesize delegate;
@synthesize nameNewText;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setNameNewText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)cancel:(id)sender
{
	[self.delegate RZLNewItemCtrlDelegateDidCancel:self];
}
- (IBAction)done:(id)sender
{
    
    NSString *newitem = self.nameNewText.text;
    

    [self.delegate RZLNewItemCtrl:self DidAddItem:newitem];
}

@end
