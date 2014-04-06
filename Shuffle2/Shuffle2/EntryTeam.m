//
//  EntryTeam.m
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import "EntryTeam.h"
#import "EntryMember.h"

@interface EntryTeam ()
{
    // |_members|
    //     key   - |EntryMember|の|identifier|を文字列に変換した値
    //     value - |EntryMember|オブジェクト
    NSMutableDictionary *_members;
}

// |identifier|を文字列に変換
- (NSString *)stringIdentifier:(NSNumber *)identifier;
// 使われていない|identifier|をさがす
- (NSNumber *)findUnusedIdentifier;

@end

@implementation EntryTeam

//================================================================
- (id)init
{
    self = [super init];
    if (!self) return nil;

    // Additional initializer
    _members = [[NSMutableDictionary alloc] init];

    return self;
}

#pragma mark

//================================================================
// メンバーの参照
- (EntryMember *)memberForIdentifier:(NSNumber *)identifier
{
    return _members[[self stringIdentifier:identifier]];
}

//================================================================
// メンバーの追加
- (void)addMember:(EntryMember *)member
{
    _members[[self stringIdentifier:member.identifier]] = member;
}

//================================================================
// メンバーの追加 - IDを内部で自動採番
- (void)addMemberWithAutoNumberingIndentifier:(EntryMember *)member
{
    member.identifier = [self findUnusedIdentifier];
    [self addMember:member];
}

//================================================================
// メンバーの削除
- (void)removeMemberForIdentifier:(NSNumber *)identifier
{
    [_members removeObjectForKey:[self stringIdentifier:identifier]];
}

//================================================================
// 全メンバーの削除
- (void)removeAllMembers
{
    [_members removeAllObjects];
}

//================================================================
// 全メンバー数を取得
- (NSUInteger)countAllMembers
{
    return _members.count;
}

//================================================================
// メンバーがいるかどうか
- (BOOL)containsMember
{
    return ([self countAllMembers] > 0);
}

//================================================================
// 全メンバーのID(|identifier|)を取得
- (NSArray *)identifiersOfAllMembers
{
    NSMutableArray *identifiers = [NSMutableArray arrayWithCapacity:[self countAllMembers]];

    NSEnumerator *stringIdentifiers = [_members keyEnumerator];
    NSString *stringIdentifier;
    while (stringIdentifier = (NSString *)[stringIdentifiers nextObject]) {
        NSNumber *identifier = @([stringIdentifier integerValue]);
        [identifiers addObject:identifier];
    }

    return (NSArray *)identifiers;
}

//================================================================
// 全メンバーの名前(|name|)を取得
- (NSArray *)namesOfAllMembers
{
    NSMutableArray *names = [NSMutableArray arrayWithCapacity:[self countAllMembers]];

    NSEnumerator *members = [_members objectEnumerator];
    EntryMember *member;
    while (member = (EntryMember *)[members nextObject]) {
        [names addObject:member.name];
    }

    return (NSArray *)names;
}

#pragma mark Inner Method

//================================================================
// |identifier|を文字列に変換
- (NSString *)stringIdentifier:(NSNumber *)identifier
{
    return [NSString stringWithFormat:@"%lu", [identifier unsignedLongValue]];
}

//================================================================
// 使われていない|identifier|をさがす
- (NSNumber *)findUnusedIdentifier
{
    NSArray *sorted = [[self identifiersOfAllMembers] sortedArrayUsingSelector:@selector(compare:)];
    NSNumber *max = (NSNumber *)[sorted lastObject];

    // メンバーがいる場合、最大の |identifier| + 1 を返し
    // メンバーがいなければ、初期値として 1 を返す
    NSNumber *unused = [NSNumber numberWithUnsignedLong:(max ? ([max unsignedLongValue] + 1) : 1)];
    return unused;
}

@end
