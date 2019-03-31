//
//  ViewController.m
//  CommentDemo
//
//  Created by ChenQing on 2019/3/31.
//  Copyright © 2019年 ChenQing. All rights reserved.
//

#import "ViewController.h"
#import "BulletManager.h"
#import "BulletView.h"

@interface ViewController ()

@property (nonatomic,strong) BulletManager *manager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[BulletManager alloc]init];
    __weak typeof(self) weakSelf = self;
    self.manager.bulletManagerBlock = ^(BulletView *view) {
        [weakSelf addBullet:view];
    };
    UIButton *startBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.frame=CGRectMake(50, 100, 50, 30);
    [startBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startBtn setTitle:@"start" forState:UIControlStateNormal];
    startBtn.titleLabel.font= [UIFont systemFontOfSize:14];
    startBtn.backgroundColor= [UIColor lightGrayColor];
    [startBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    stopBtn.frame=CGRectMake(200, 100, 50, 30);
    [stopBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [stopBtn setTitle:@"stop" forState:UIControlStateNormal];
    stopBtn.titleLabel.font= [UIFont systemFontOfSize:14];
    stopBtn.backgroundColor= [UIColor lightGrayColor];
    [stopBtn addTarget:self action:@selector(clickStopBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}

- (void)clickBtn:(id)sender{
    [self.manager start];
}
- (void)clickStopBtn:(id)sender{
    [self.manager stop];
}

- (void)addBullet:(BulletView *)view{
    CGFloat mainWidth = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(mainWidth, 200 + 50*view.trajectory, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    
    [view startAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
