//
//  EntryTeam.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryMember;

@interface EntryTeam : NSObject

// メンバーの参照
- (EntryMember *)memberForIdentifier:(NSNumber *)identifier;
// メンバーの追加
- (void)addMember:(EntryMember *)member;
// メンバーの追加 - IDを内部で自動採番
- (void)addMemberWithAutoNumberingIndentifier:(EntryMember *)member;
// メンバーの削除
- (void)removeMemberForIdentifier:(NSNumber *)identifier;
// 全メンバーの削除
- (void)removeAllMembers;

// 全メンバー数を取得
- (NSUInteger)countAllMembers;
// メンバーがいるかどうか
- (BOOL)containsMember;

// 全メンバーのID(|identifier|)を取得
- (NSArray *)identifiersOfAllMembers;
// 全メンバーの名前(|name|)を取得
- (NSArray *)namesOfAllMembers;

@end
