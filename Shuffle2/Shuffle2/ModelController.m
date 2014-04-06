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

    // シャッルフ後のメンバー
    EntryTeam *_leftShuffledMembers;     // 1つ目
    EntryTeam *_rightShuffledMembers;    // 2つ目
}

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
    _allMembers           = [[EntryTeam alloc] init];
    _entryMembers         = [[EntryTeam alloc] init];
//    _leftShuffledMembers  = [[EntryTeam alloc] init];
//    _rightShuffledMembers = [[EntryTeam alloc] init];

    [self loadAllMembersFromStore];

    return self;
}

#pragma mark

//================================================================
// エントリーしたメンバーを参照
- (EntryTeam *)teamEntry
{
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

    return _entryMembers;
}

//================================================================
// シャッフル後の1つ目のチームメンバーを参照
- (EntryTeam *)teamLeft
{
    return nil;////
//    return _leftShuffledMembers;
}

//================================================================
// シャッフル後の2つ目のチームメンバーを参照
- (EntryTeam *)teamRight
{
    return nil;////
//    return _rightShuffledMembers;
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
