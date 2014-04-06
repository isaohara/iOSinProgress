//
//  ModelController.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EntryTeam;
//@class EntryMember;

@interface ModelController : NSObject

// 全メンバーを参照

// エントリーしたメンバーを参照
- (EntryTeam *)teamEntry;

// シャッフル済みかどうか

// エントリーしたメンバーをシャッフルする

// シャッフル後の1つ目のチームメンバーを参照
- (EntryTeam *)teamLeft;

// シャッフル後の2つ目のチームメンバーを参照
- (EntryTeam *)teamRight;

@end
