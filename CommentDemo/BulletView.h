//
//  BulletView.h
//  CommentDemo
//
//  Created by ChenQing on 2019/3/31.
//  Copyright © 2019年 ChenQing. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, BulletStatus) {
    BulletStart,  // 弹幕开始
    BulletEnter,  //弹幕移动到屏幕中
    BulletEnd   // 弹幕移除屏幕
};

@interface BulletView : UIView

@property (nonatomic,assign) NSInteger trajectory; //弹道
@property (nonatomic,copy) void(^moveStatusBlock)(BulletStatus status);//弹幕状态回调
//初始化弹幕
- (instancetype)initWithComment:(NSString *)comment;
//开始动画
- (void)startAnimation;
//结束动画
- (void)stopAnimation;

@end
