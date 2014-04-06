//
//  ResultViewController.m
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()

- (IBAction)clear:(UIButton *)sender;

@end

@implementation ResultViewController

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
}

//================================================================
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

//================================================================
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

# pragma mark - Event Handlers

//================================================================
// [Done] buttonをタップ
- (IBAction)done:(id)sender
{
    [self.delegate resultViewControllerDidFinish:self];
}

//================================================================
// [Clear] buttonをタップ
- (IBAction)clear:(UIButton *)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear the result?"
                                                    message:@"Click [Proceed] to clear the result."
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Proceed", nil];
    [alert show];
}

# pragma mark Delegate

//================================================================
// AlertViewのボタンをタップ
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // [Cancel] button
        NSLog(@"キャンセル");
    }
    else if (buttonIndex == 1) {
        // [Proceed] button
        NSLog(@"続行");
        //// ここに、the result dataの消去処理を
    }
}

@end
