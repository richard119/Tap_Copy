//
//  RZLNewItemCtrl.h
//  CB_tableview1
//
//  Created by 凌 钟 on 12-8-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RZLNewItemCtrl;

@protocol RZLNewItemCtrlDelegate <NSObject>
- (void)RZLNewItemCtrlDelegateDidCancel:
            (RZLNewItemCtrl *)controller;

//- (void)RZLNewItemCtrlDelegateDidSave:
//(RZLNewItemCtrl *)controller;

- (void)RZLNewItemCtrl:(RZLNewItemCtrl *)controller
            DidAddItem:(NSString *) item;

@end

@interface RZLNewItemCtrl : UITableViewController

@property (nonatomic, weak) id <RZLNewItemCtrlDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITextField *nameNewText;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
