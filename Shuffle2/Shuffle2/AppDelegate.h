//
//  AppDelegate.h
//  Shuffle2
//
//  Created by Isao HARA on 2014/04/05.
//  Copyright (c) 2014年 IsaoHARA. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ModelController;

//================================================================
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//----------------
@property (strong, nonatomic) ModelController *modelController;

@end
