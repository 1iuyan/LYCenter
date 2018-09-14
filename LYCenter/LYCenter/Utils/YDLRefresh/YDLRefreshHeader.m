//
//  YDLRefreshHeader.m
//  NewYDLUser
//
//  Created by liuyan on 2018/1/23.
//  Copyright © 2018年 com.yidianling.com. All rights reserved.
//

#import "YDLRefreshHeader.h"

@interface YDLRefreshHeader ()

@property (nonatomic, weak) UIImageView *circleView;

@end

@implementation YDLRefreshHeader
#pragma mark - 重写方法
#pragma mark 在这里做一些初始化配置（比如添加子控件）
- (void)prepare{
    [super prepare];
    // 箭头
    CGFloat arrowX = self.mj_w * 0.5-18;
    UIImageView *circleView = [[UIImageView alloc] initWithFrame:CGRectMake(arrowX, 5, 36, 36)];
    [circleView setImage:[UIImage imageNamed:@"refreshIcon"]];
    circleView.tag = 111;
    _circleView = circleView;
    for (UIView *subView in self.subviews) {
        if (subView.tag == 111) {
            [subView removeFromSuperview];
        }
    }
    [self addSubview:circleView];
}

#pragma mark 在这里设置子控件的位置和尺寸
- (void)placeSubviews{
    [super placeSubviews];
    self.circleView.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change{
    [super scrollViewContentOffsetDidChange:change];
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change{
    [super scrollViewContentSizeDidChange:change];
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change{
    [super scrollViewPanStateDidChange:change];
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state{
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:{
            if (oldState == MJRefreshStateRefreshing) {
                [_circleView.layer removeAllAnimations];
            } else {
                [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                    [_circleView.layer removeAllAnimations];
                }];
            }
        }
            break;
        case MJRefreshStatePulling:{
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                [_circleView.layer removeAllAnimations];
            }];
        }
            break;
        case MJRefreshStateRefreshing:{
            CABasicAnimation* rotate =  [CABasicAnimation animationWithKeyPath: @"transform.rotation.z"];
            [rotate setToValue: [NSNumber numberWithFloat: M_PI / 2]];
            rotate.repeatCount = 1000;
            rotate.duration = 0.25;
            rotate.cumulative = TRUE;
            [_circleView.layer addAnimation:rotate forKey:@"rotateAnimation"];
        }
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent{
    [super setPullingPercent:pullingPercent];
}


@end
