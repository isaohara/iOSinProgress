//
//  EntryMember.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/06.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryMember : NSObject

// ID(1以上の正の整数)
@property (nonatomic) NSNumber *identifier;

// 名前
@property (nonatomic) NSString *name;

// ソートキー(≒ふりがな)
@property (nonatomic) NSString *sortKey;

// エントリー済み(=YES)かどうか
@property (assign, nonatomic, getter=isRegistered) BOOL registered;

@end
