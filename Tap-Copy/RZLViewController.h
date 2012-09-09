//
//  RZLViewController.h
//  CB_tableview1
//
//  Created by 凌 钟 on 12-8-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RZLNewItemCtrl.h"

@interface RZLViewController : UITableViewController <RZLNewItemCtrlDelegate>
{
    
}

@property (strong, nonatomic) NSMutableArray *list; 


-(IBAction)toggleMove;

@end
