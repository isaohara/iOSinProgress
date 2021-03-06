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

@property (weak, nonatomic) IBOutlet UIView *tray;      // 名前プレートを配置する枠
@property (weak, nonatomic) IBOutlet UILabel *plate;    // 名前プレート
@property (weak, nonatomic) IBOutlet UILabel *teams;    // シャッフルするチーム数

@property (weak, nonatomic) IBOutlet UIStepper *changeTeams;    // チーム数変更
@property (weak, nonatomic) IBOutlet UIButton *shuffle;         // シャッフルボタン
@property (weak, nonatomic) IBOutlet UIButton *result;          // 結果ボタン
- (IBAction)changeTeams:(UIStepper *)sender;            // チーム数変更
- (IBAction)shuffle:(UIButton *)sender;                 // シャッフルボタン
- (IBAction)result:(UIButton *)sender;                  // 結果ボタン

// アプリケーション共有モデルコントローラ
- (ModelController *)appModelController;
// シャッフル済みかどうかでボタン等の有効・無効を切り替える
- (void)switchEnabledAsShuffled;
// メンバーを画面に表示
- (void)showTeamMembers:(EntryTeam *)team;
// 名前プレートを作成して表示
- (CGRect)createPlate:(NSString *)name at:(CGPoint)origin on:(UIView *)tray;

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

    _plate.hidden = YES;    // 名前プレート(テンプレート)は非表示に

    // シャッフル済みかどうかで、ボタン等の有効/無効を切り替える
    [self switchEnabledAsShuffled];

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
// シャッフル済みかどうかでボタン等の有効・無効を切り替える
- (void)switchEnabledAsShuffled
{
    BOOL isShuffled = [[self appModelController] isShuffled];
    _shuffle.enabled = _teams.enabled = _changeTeams.enabled = !isShuffled;
    _result.enabled = isShuffled;
}

//================================================================
// メンバーを画面に表示
- (void)showTeamMembers:(EntryTeam *)team
{
    CGFloat margin = _plate.frame.size.width;
    CGPoint origin = CGPointMake(margin, margin);

    NSArray *names = [team namesOfAllMembers];

    for (NSString *name in names) {
        CGRect frame = [self createPlate:name at:origin on:_tray];
        origin = CGPointMake(frame.origin.x + frame.size.width + margin, frame.origin.y);
    }
}

//================================================================
// 名前プレートを作成して表示 - 戻り値:作成した名前プレートの領域(|CGRect|)
- (CGRect)createPlate:(NSString *)name at:(CGPoint)origin on:(UIView *)tray;
{
    // 設定値を決める(名前プレートひな形の属性も使う)
    UIFont *font = _plate.font;
    NSTextAlignment textAlignment = _plate.textAlignment;
    UIColor *textColor = _plate.textColor;
    UIColor *backgroundColor = _plate.backgroundColor;
    CGFloat margin = _plate.frame.size.width;
    CGFloat height = _plate.frame.size.height;

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
    CGFloat limit = _tray.frame.size.width - margin;
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
        // [Result] buttonをタップ
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

#pragma mark Event Handler

//================================================================
- (IBAction)changeTeams:(UIStepper *)sender
{
    NSUInteger val = (NSUInteger)sender.value;
    _teams.text = [NSString stringWithFormat:@"%lu", val];
}

//================================================================
- (IBAction)shuffle:(UIButton *)sender
{
    NSUInteger teams = (NSUInteger)[_teams.text integerValue];
    ModelController *mc = [self appModelController];
    if (!mc.isShuffled) {
        [mc shuffle:teams];
    }

    [self switchEnabledAsShuffled];
}

//================================================================
- (IBAction)result:(UIButton *)sender
{
}

@end
