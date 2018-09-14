//
//  LYCenterTitleView.m
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import "LYCenterTitleView.h"

@interface LYCenterTitleView ()

@property (nonatomic, strong) NSArray *titles;
/** 所有按钮的数组 */
@property (nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, strong) UIView *backView;

@end

@implementation LYCenterTitleView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    if (self = [super initWithFrame:frame]) {
        self.titles = titles;
        self.backgroundColor = [UIColor whiteColor];
        [self uiconfig];
    }
    return self;
}

- (void)setCurrentTitleIndex:(NSInteger)index {
    [self selectTitleButton:self.titleBtns[index]];
}

- (void)titleClick:(UIButton *)button {
    // 0.获取角标
    NSInteger i = button.tag;
    !self.didTitleClick ? : self.didTitleClick(i);
    // 1.让标题按钮选中
    [self selectTitleButton:button];
}

- (void)selectTitleButton:(UIButton *)btn {
    // 恢复上一个按钮颜色
    [_selectButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
    _selectButton.backgroundColor = UIColorFromRGB(0xf5f5f8);
    // 设置当前选中按钮的颜色
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = UIColorFromRGB(0x1da1f2);
    // 记录当前选中的按钮
    _selectButton = btn;
}

- (void)uiconfig {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(15, 17, self.frame.size.width - 30, self.frame.size.height - 34)];
    _backView.backgroundColor = [UIColor whiteColor];
    _backView.layer.cornerRadius = 6;
    _backView.clipsToBounds = YES;
    [self addSubview:_backView];
    CGFloat btnW = (self.frame.size.width - 32) / self.titles.count;
    CGFloat btnH = self.frame.size.height - 34;
    [self.titles enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = idx;
        btn.frame = (CGRect) {(btnW + 1) * idx, 0, btnW, btnH};
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        btn.backgroundColor = UIColorFromRGB(0xf5f5f8);
        [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchDown];
        if (@available(iOS 8.2, *)) {
            btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightThin];
        } else {
            btn.titleLabel.font = [UIFont systemFontOfSize:15];
        }
        if (!idx) {
            [self titleClick:btn];
        }
        [self.backView addSubview:btn];
        [self.titleBtns addObject:btn];
    }];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, kScreecWide, 0.5)];
    _lineView.backgroundColor = UIColorFromRGB(0xe0e0e0);
    _lineView.hidden = YES;
    [self addSubview:_lineView];
}

#pragma mark - 懒加载
- (NSMutableArray<UIButton *> *)titleBtns {
    if (!_titleBtns) {
        _titleBtns = [NSMutableArray array];
    }
    return _titleBtns;
}


@end
