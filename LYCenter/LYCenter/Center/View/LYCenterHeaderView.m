//
//  LYCenterHeaderView.m
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import "LYCenterHeaderView.h"

@implementation LYCenterHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        self.userInteractionEnabled = YES;
    }
    return self;
}

@end
