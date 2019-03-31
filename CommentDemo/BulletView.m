//
//  BulletView.m
//  CommentDemo
//
//  Created by ChenQing on 2019/3/31.
//  Copyright © 2019年 ChenQing. All rights reserved.
//

#import "BulletView.h"

#define  Padding 15  // 内间距
#define  BulletSpace 50

@interface BulletView ()

@property (nonatomic,copy) UILabel *commentLabel;

@end

@implementation BulletView

//初始化弹幕
- (instancetype)initWithComment:(NSString *)comment {
    if (self = [super init]) {
        self.backgroundColor = [UIColor redColor];
        self.layer.cornerRadius = 15;
        self.layer.masksToBounds = YES;
        [self addSubview:self.commentLabel];
        //计算弹幕实际宽度
        NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:dict].width+10;
        self.bounds = CGRectMake(0, 0, width+2*Padding, 30);
        self.commentLabel.frame = CGRectMake(Padding, 0, width, 30);
        self.commentLabel.text = comment;
    }
    return self;
}
//开始动画
- (void)startAnimation {
    //根据弹幕长度执行动画效果
    // v（速度） = s（位移）/t（时间）
    if (self.moveStatusBlock) {
        self.moveStatusBlock(BulletStart);
    }
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 5.0;
    CGFloat totalWidth = mainWidth + CGRectGetWidth(self.bounds);
    __block CGRect frame = self.frame;
    CGFloat speed = totalWidth/duration;
    CGFloat enterDuration = (CGRectGetWidth(self.bounds)+BulletSpace)/speed;
    
    [self performSelector:@selector(updateStatus:) withObject:nil afterDelay:enterDuration];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        frame.origin.x -= totalWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if (self.moveStatusBlock) {
            self.moveStatusBlock(BulletEnd);
        }
    }];
}
//结束动画
- (void)stopAnimation {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
}

- (void)updateStatus:(id)sender{
    if (self.moveStatusBlock) {
        self.moveStatusBlock(BulletEnter);
    }
}

- (UILabel *)commentLabel {
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentLabel.font = [UIFont systemFontOfSize:14];
        _commentLabel.textColor = [UIColor blueColor];
        _commentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _commentLabel;
}

@end
