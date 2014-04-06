//
//  ResultViewController.m
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import "ResultViewController.h"
#import "AppDelegate.h"
#import "ModelController.h"
#import "EntryTeam.h"
#import "EntryMember.h"

@interface ResultViewController ()

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *trays;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *plates;

- (IBAction)clear:(UIButton *)sender;

// アプリケーション共有モデルコントローラ
- (ModelController *)appModelController;
// メンバーを画面に表示
- (void)showShuffledMembers:(NSArray *)teams;
// 名前プレートを作成して表示
- (CGRect)createPlate:(NSString *)name at:(CGPoint)origin on:(UIView *)tray using:(UILabel *)plateTemplate;

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

    // シャッフルされたメンバーを画面に表示
    for (UILabel* plate in _plates) {   // 名前プレート(テンプレート)は非表示に
        plate.hidden = YES;
    }

    NSArray *teams = [[self appModelController] teamShuffled];
    if (teams.count < 3) {
        ((UIView *)_trays[2]).hidden = YES;
    }
    [self showShuffledMembers:teams];
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
// シャッフルされたメンバーを画面に表示
- (void)showShuffledMembers:(NSArray *)teams
{
    for (NSUInteger i = 0; i < teams.count; ++i) {
        CGFloat margin = ((UILabel *)_plates[i]).frame.size.width;
        CGPoint origin = CGPointMake(margin, margin);

        NSArray *names = [(EntryTeam *)teams[i] namesOfAllMembers];

        for (NSString *name in names) {
            CGRect frame = [self createPlate:name at:origin on:_trays[i] using:_plates[i]];
            origin = CGPointMake(frame.origin.x + frame.size.width + margin, frame.origin.y);
        }

    }
}

//================================================================
// 名前プレートを作成して表示
- (CGRect)createPlate:(NSString *)name at:(CGPoint)origin on:(UIView *)tray using:(UILabel *)plateTemplate
{
    // 設定値を決める(名前プレートひな形の属性も使う)
    UIFont *font = plateTemplate.font;
    NSTextAlignment textAlignment = plateTemplate.textAlignment;
    UIColor *textColor = plateTemplate.textColor;
    UIColor *backgroundColor = plateTemplate.backgroundColor;
    CGFloat margin = plateTemplate.frame.size.width;
    CGFloat height = plateTemplate.frame.size.height;

    // 名前プレートを作成
    UILabel *plate = [[UILabel alloc] init];
    plate.text = name;
    plate.font = font;
    plate.textAlignment = textAlignment;
    plate.textColor = textColor;
    plate.backgroundColor = backgroundColor;

    [plate sizeToFit];

    CGFloat width = plate.frame.size.width + margin;
    plate.frame = CGRectMake(origin.x, origin.y, width, height);

    // 枠をはみ出さないように調整
    CGFloat limit = tray.frame.size.width - margin;
    if (plate.frame.origin.x + plate.frame.size.width > limit) {
        // はみ出した場合
        CGFloat nextX = margin;
        CGFloat nextY = plate.frame.origin.y + plate.frame.size.height + margin;
        plate.frame = CGRectMake(nextX, nextY, width, height);
    }

    // 名前プレートを表示
    [tray addSubview:plate];

    return plate.frame;
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
