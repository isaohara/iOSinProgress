//
//  MainViewController.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntryTableViewController.h"
#import "ResultViewController.h"


//================================================================
@interface MainViewController : UIViewController <ResultViewControllerDelegate, EntryTableViewControllerDelegate>
@end
