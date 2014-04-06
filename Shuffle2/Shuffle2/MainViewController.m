//
//  MainViewController.m
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import "MainViewController.h"
#import "AppDelegate.h"
#import "ModelController.h"
#import "EntryTeam.h"
#import "EntryMember.h"

@interface MainViewController ()

// アプリケーション共有モデルコントローラ
- (ModelController *)appModelController;

// メンバーを画面に表示
- (void)showTeamMembers:(EntryTeam *)team;

@end

@implementation MainViewController

//================================================================
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//================================================================
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // エントリーされたメンバーを画面に表示
    EntryTeam *team = [[self appModelController] teamEntry];
    [self showTeamMembers:team];
}

//================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

#pragma mark Inner Method

//================================================================
// アプリケーション共有モデルコントローラ
- (ModelController *)appModelController
{
    AppDelegate *appDelegete = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return appDelegete.modelController;
}

//================================================================
// メンバーを画面に表示
- (void)showTeamMembers:(EntryTeam *)team
{
    NSArray *names = [team namesOfAllMembers];

    //// to be continued...
}

#pragma mark - Navigation

//================================================================
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

    if ([[segue identifier] isEqualToString:@"toEntry"]) {
        // [Entry] buttonをタップ
        [[segue destinationViewController] setDelegate:self];
    }
    else if ([[segue identifier] isEqualToString:@"toResult"]) {
        // [Shuffle] buttonをタップ
        [[segue destinationViewController] setDelegate:self];
    }
}

#pragma mark Delegate

//================================================================
- (void)entryTableViewControllerDidFinish:(EntryTableViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//================================================================
- (void)resultViewControllerDidFinish:(ResultViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
