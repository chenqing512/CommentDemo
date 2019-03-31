//
//  BulletManager.h
//  CommentDemo
//
//  Created by ChenQing on 2019/3/31.
//  Copyright © 2019年 ChenQing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BulletView;

@interface BulletManager : NSObject

@property (nonatomic,copy) void(^bulletManagerBlock)(BulletView *view);

//弹幕开始执行
- (void)start;
//弹幕停止执行
- (void)stop;

@end
