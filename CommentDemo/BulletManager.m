//
//  BulletManager.m
//  CommentDemo
//
//  Created by ChenQing on 2019/3/31.
//  Copyright © 2019年 ChenQing. All rights reserved.
//

#import "BulletManager.h"
#import "BulletView.h"

@interface BulletManager ()
//弹幕的数据来源
@property (nonatomic,copy) NSMutableArray *dataSource;
//弹幕使用过程中的数组变量
@property (nonatomic,copy) NSMutableArray *bulletComments;
//存储弹幕view的数组变量
@property (nonatomic,copy) NSMutableArray *bulletViews;

@property (nonatomic,assign) BOOL isStopAnimation;

@end

@implementation BulletManager

- (instancetype)init {
    if (self = [super init]) {
        self.isStopAnimation = YES;
    }
    return self;
}

//弹幕开始执行
- (void)start {
    if (!self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.dataSource];
    [self initBulletComment];
}
//随机分配弹道轨迹
- (void)initBulletComment {
    NSMutableArray *trajectorys = [NSMutableArray arrayWithArray:@[@0,@1,@2,@3]];
    for (int i=0;i<4;i++){
        if (self.bulletComments.count>0) {
            NSInteger index = arc4random()%trajectorys.count;
            NSInteger trajectory = [[trajectorys objectAtIndex:index] integerValue];
            [trajectorys removeObjectAtIndex:index];
            NSString *comment = [self.bulletComments firstObject];
            [self.bulletComments removeObjectAtIndex:0];
            [self initBulletView:comment withTrajectory:trajectory];
        }
    }
}

- (void)initBulletView:(NSString *)comment withTrajectory:(NSInteger)trajectory {
    BulletView *view = [[BulletView alloc]initWithComment:comment];
    view.trajectory = trajectory;
    [self.bulletViews addObject:view];
    __weak typeof(view) weakView = view;
    __weak typeof(self) weakSelf = self;
    view.moveStatusBlock = ^(BulletStatus status) {
        switch (status) {
            case BulletStart:
            {
                [weakSelf.bulletViews addObject:weakView];
                break;
            }
            case BulletEnter:
            {
                NSString *commontStr = [weakSelf nextComment];
                if (commontStr) {
                    [weakSelf initBulletView:commontStr withTrajectory:trajectory];
                }
                break;
            }
            case BulletEnd:
            {
                if ([weakSelf.bulletViews containsObject:weakView]) {
                    [weakView stopAnimation];
                    [weakSelf.bulletViews removeObject:weakView];
                }
                if (weakSelf.bulletViews.count == 0) {
                    if (self.isStopAnimation) {
                        return ;
                    }
                    self.isStopAnimation = YES;
                    [weakSelf start];
                }
                break;
            }
                
            default:
                break;
        }
        
    };
    if (self.bulletManagerBlock) {
        self.bulletManagerBlock(view);
    };
}

- (NSString *)nextComment {
    if (self.bulletComments.count == 0) {
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    [self.bulletComments removeObjectAtIndex:0];
    return comment;
}

//弹幕停止执行
- (void)stop {
    if (self.isStopAnimation) {
        return;
    }
    self.isStopAnimation = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BulletView *view = obj;
        [view stopAnimation];
    }];
    [self.bulletViews removeAllObjects];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithArray:@[@"弹幕测试数据1",
                                                       @"弹幕测试数据2～～～～～～～～",
                                                       @"弹幕测试数据3～～～～～～～～～～～～～",
                                                       @"弹幕测试数据4～～～～～～～～",
                                                       @"弹幕测试数据5～～～～～～～～～～～～～",
                                                       @"弹幕测试数据6",
                                                       @"弹幕测试数据7～～～～～",
                                                       @"弹幕测试数据8～～～～～+++～～～～～～～～",
                                                       @"弹幕测试数据9～～～～～～",
                                                       @"弹幕测试数据10～～～～---～～～～～～",
                                                       @"弹幕测试数据11",
                                                       @"弹幕测试数据12～～～～～～",
                                                       @"弹幕测试数据13～～～～～～～～",
                                                       @"弹幕测试数据14～～～～～～～555～",
                                                       @"弹幕测试数据15～～～～～～～66～～～～～～"
                                                       ]];
    }
    return _dataSource;
}

- (NSMutableArray *)bulletComments {
    if (!_bulletComments) {
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

- (NSMutableArray *)bulletViews {
    if (!_bulletViews) {
        _bulletViews = [NSMutableArray array];
    }
    return  _bulletViews;
}

@end
