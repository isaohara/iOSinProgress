//
//  ResultViewController.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <UIKit/UIKit.h>

//================================================================
@class ResultViewController;

@protocol ResultViewControllerDelegate

- (void)resultViewControllerDidFinish:(ResultViewController *)controller;

@end

//================================================================
@interface ResultViewController : UIViewController

@property (weak, nonatomic) id<ResultViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;

@end
