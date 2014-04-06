//
//  ModelController.m
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import "ModelController.h"
#import "EntryTeam.h"
#import "EntryMember.h" //// for Stub

@interface ModelController ()
{
    // 全メンバー
    EntryTeam *_allMembers;
    // エントリーしたメンバー
    EntryTeam *_entryMembers;

    // シャッフル後のメンバー
    // |EntryTeam|の配列
    NSMutableArray *_teamsShuffled;
}

// エントリーしたメンバーのデータ作成後に、メンバー(全メンバー)のデータに変更あったか(=YES)どうか
@property (assign, nonatomic) BOOL dirty;

// (ストレージから)メンバーのデータを読み込む
- (void)loadAllMembersFromStore;
- (void)stub_loadAllMembersFromStore;   //// Stub ****


@end

@implementation ModelController

//================================================================
- (id)init
{
    self = [super init];
    if (!self) return nil;

    // Additional initializer
    _allMembers = [[EntryTeam alloc] init];
    _entryMembers = [[EntryTeam alloc] init];
    _teamsShuffled = [[NSMutableArray alloc] init];
    _dirty = YES;

    [self loadAllMembersFromStore];

    return self;
}

#pragma mark

//================================================================
// 全メンバーを参照
- (EntryTeam *)teamAll
{
    return _allMembers;
}

//================================================================
// エントリーしたメンバーを参照
- (EntryTeam *)teamEntry
{
    if (_dirty) {
        // データを再作成
        [_entryMembers removeAllMembers];

        NSArray *allIdentifiers = [_allMembers identifiersOfAllMembers];
        NSEnumerator *allEnumerator = [allIdentifiers objectEnumerator];
        NSNumber *identifier;
        while (identifier = (NSNumber *)[allEnumerator nextObject]) {
            EntryMember *member = [_allMembers memberForIdentifier:identifier];
            if (member.isRegistered) {
                [_entryMembers addMember:member];
            }
        }
    }

    return _entryMembers;
}

//================================================================
// エントリーしたメンバーをシャッフルする (|inTeams| - チーム数)
- (void)shuffle:(NSUInteger)inTeams
{
    // チーム数分のチームオブジェクトを作成
    for (NSUInteger i = 0; i < inTeams; ++i) {
        [_teamsShuffled addObject:[[EntryTeam alloc] init]];
    }

    // エントリーしたメンバのデータを準備
    EntryTeam *entry = [self teamEntry];
    NSMutableArray * identifiersEntry = [NSMutableArray arrayWithArray:[entry identifiersOfAllMembers]];

    // シャッフル
    NSUInteger indexShuffled = 0;
    while (identifiersEntry.count > 0) {
        // 乱数でメンバーを選び、チームに分ける
        NSUInteger indexEntry = ((NSUInteger)arc4random() % identifiersEntry.count);

        EntryMember *member = [entry memberForIdentifier:identifiersEntry[indexEntry]];
        [_teamsShuffled[indexShuffled] addMember:member];

        [identifiersEntry removeObjectAtIndex:indexEntry];

        ++indexShuffled;
        if (indexShuffled >= inTeams) {
            indexShuffled = 0;
        }
    }
}

//================================================================
// シャッフル後のチームメンバーを参照
- (NSArray *)teamShuffled
{
    return (NSArray *)_teamsShuffled;
}

//================================================================
// シャッフル済みかどうか
- (BOOL)isShuffled
{
    return (_teamsShuffled.count >= 2);
}

//================================================================
// シャッフルをクリア
- (void)initializeShuffled
{
    [_teamsShuffled removeAllObjects];
}

#pragma mark Inner Method

//================================================================
- (void)loadAllMembersFromStore
{
    [self stub_loadAllMembersFromStore];
}
//// Stub ****
- (void)stub_loadAllMembersFromStore
{
    EntryMember *m;

    //--------------------------------
    // 全メンバのデータを作成
    _dirty = YES;
    m = [[EntryMember alloc] init];  m.name = @"原";  m.sortKey = @"ハラ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"松原";  m.sortKey = @"マツバラ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"兼利";  m.sortKey = @"カネトシ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"柳田";  m.sortKey = @"ヤナギダ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"石井";  m.sortKey = @"イシイ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];

    m = [[EntryMember alloc] init];  m.name = @"横田";  m.sortKey = @"ヨコタ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"和田";  m.sortKey = @"ワダ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"算用子";  m.sortKey = @"サンヨウシ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"中山";  m.sortKey = @"ナカヤマ";  m.registered = YES;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"秋田";  m.sortKey = @"アキタ";  m.registered = NO;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];

    m = [[EntryMember alloc] init];  m.name = @"突元";  m.sortKey = @"ツクモト";  m.registered = NO;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"石崎";  m.sortKey = @"イシザキ";  m.registered = NO;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"吉川";  m.sortKey = @"ヨシカワ";  m.registered = NO;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
    m = [[EntryMember alloc] init];  m.name = @"悦喜";  m.sortKey = @"エキ";  m.registered = NO;
    [_allMembers addMemberWithAutoNumberingIndentifier:m];
}

@end
