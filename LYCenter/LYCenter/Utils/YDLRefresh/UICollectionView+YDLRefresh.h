//
//  UICollectionView+YDLRefresh.h
//  NewYDLUser
//
//  Created by liuyan on 2018/1/29.
//  Copyright © 2018年 com.yidianling.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (YDLRefresh)
- (void)loadHeaderRefreshWithHeaderRefreshingBlock:(MJRefreshComponentRefreshingBlock)headerRefreshingBlock;


- (void)loadFooterRefreshWithFootRefreshingBlock:(MJRefreshComponentRefreshingBlock)footRefeshingBlock;

- (void)loadRefreshWithHeaderRefreshingBlock:(MJRefreshComponentRefreshingBlock)headerRefreshingBlock FootRefreshingBlock:(MJRefreshComponentRefreshingBlock)footRefeshingBlock;

- (void)endRefreshWithIsNoMoreData:(BOOL)isNoMoreData;

- (void)beginHeaderRefresh;
@end
