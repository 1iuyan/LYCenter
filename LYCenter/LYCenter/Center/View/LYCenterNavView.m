//
//  LYCenterNavView.m
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import "LYCenterNavView.h"

@interface LYCenterNavView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LYCenterNavView

- (instancetype)init {
    self = [super initWithFrame:CGRectMake(0, 0, kScreecWide, kNavgationBarHeight)];
    if (self) {
        self.contentMode = UIViewContentModeScaleToFill;
        self.backgroundColor = [UIColor yellowColor];
        self.alpha = 0;
        [self uiconfig];
    }
    return self;
}

- (void)uiconfig {
//    self.image = [UIImage imageNamed:@"home_search_back"];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"详情";
    _titleLabel.font = [UIFont systemFontOfSize:17];
    _titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@44);
    }];
}


@end
