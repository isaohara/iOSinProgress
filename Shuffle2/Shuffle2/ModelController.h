//
//  ModelController.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryTeam;

@interface ModelController : NSObject

// 全メンバーを参照
- (EntryTeam *)teamAll;
// エントリーしたメンバーを参照
- (EntryTeam *)teamEntry;

// エントリーしたメンバーをシャッフルする
- (void)shuffle:(NSUInteger)inTeams;
// シャッフル後のチームメンバーを参照
- (NSArray *)teamShuffled;
// シャッフル済みかどうか
- (BOOL)isShuffled;
// シャッフルをクリア
- (void)initializeShuffled;

@end
