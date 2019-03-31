# CommentDemo
接入简单，通过manager管理类操作

self.manager = [[BulletManager alloc]init];
    __weak typeof(self) weakSelf = self;
    self.manager.bulletManagerBlock = ^(BulletView *view) {
        [weakSelf addBullet:view];//添加弹幕view
    };
    
弹幕效果 可以自动控制速度  速度=距离/时间

可以自定义弹幕view
