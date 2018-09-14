//
//  LYCenterContainerCell.h
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYCenterContainerCell;

@protocol LYCenterContainerCellDelegate <NSObject>

- (void)ly_contentViewCellDidRecieveFinishRefreshingNotificaiton:(LYCenterContainerCell *)cell;

@end

@interface LYCenterContainerCell : UITableViewCell
// cell注册
+ (void)regisCellForTableView:(UITableView *)tableView;
+ (LYCenterContainerCell *)dequeueCellForTableView:(UITableView *)tableView;
// 子控制器是否可以滑动  YES可以滑动
@property (nonatomic, assign) BOOL canScroll;
// 外部segment点击更改selectIndex,切换页面
@property (assign, nonatomic) NSInteger selectIndex;
// 当前选中的selectedIndex
@property (nonatomic, assign) NSInteger currentSelectedIndex;
@property (nonatomic, weak) id<LYCenterContainerCellDelegate> delegate;

// 创建pageViewController
- (void)setPageView;
// 刷新
- (void)ly_refresh;
@end
