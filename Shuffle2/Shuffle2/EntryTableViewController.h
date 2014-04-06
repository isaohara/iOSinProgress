//
//  EntryTableViewController.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <UIKit/UIKit.h>

//================================================================
@class EntryTableViewController;

@protocol EntryTableViewControllerDelegate

- (void)entryTableViewControllerDidFinish:(EntryTableViewController *)controller;

@end

//================================================================
@interface EntryTableViewController : UITableViewController

@property (weak, nonatomic) id<EntryTableViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;

@end
