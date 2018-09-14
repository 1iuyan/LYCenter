//
//  LYCenterTitleView.h
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYCenterTitleView : UIView

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) void(^didTitleClick)(NSInteger);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

- (void)setCurrentTitleIndex:(NSInteger)index;

@end
