//
//  UITableView+YDLRefresh.m
//  NewYDLUser
//
//  Created by liuyan on 2018/1/23.
//  Copyright © 2018年 com.yidianling.com. All rights reserved.
//

#import "UITableView+YDLRefresh.h"
#import "YDLRefreshHeader.h"

@implementation UITableView (YDLRefresh)
- (void)endRefreshWithIsNoMoreData:(BOOL)isNoMoreData{
    if (self.mj_header.state == MJRefreshStateRefreshing) {
        [self.mj_header endRefreshing];
        self.mj_footer.hidden = NO;
    }
    
    if (self.mj_footer.state == MJRefreshStateRefreshing) {
        [self.mj_footer endRefreshing];
    }
    
    if (isNoMoreData) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        if (self.mj_footer.state == MJRefreshStateNoMoreData) {
            [self.mj_footer resetNoMoreData];
        }
    }
}

- (void)loadRefreshWithHeaderRefreshingBlock:(MJRefreshComponentRefreshingBlock)headerRefreshingBlock FootRefreshingBlock:(MJRefreshComponentRefreshingBlock)footRefeshingBlock{
    [self loadHeaderRefreshWithHeaderRefreshingBlock:headerRefreshingBlock];
    [self loadFooterRefreshWithFootRefreshingBlock:footRefeshingBlock];
}


- (void)loadHeaderRefreshWithHeaderRefreshingBlock:(MJRefreshComponentRefreshingBlock)headerRefreshingBlock{
    if (headerRefreshingBlock) {
        self.mj_header = [YDLRefreshHeader headerWithRefreshingBlock:^{
            headerRefreshingBlock();
        }];
    }
}


- (void)loadFooterRefreshWithFootRefreshingBlock:(MJRefreshComponentRefreshingBlock)footRefeshingBlock{
    if (footRefeshingBlock) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            footRefeshingBlock();
        }];
    }
}

- (void)beginHeaderRefresh{
    [self.mj_header beginRefreshing];
    self.mj_footer.hidden = YES;
}
@end
