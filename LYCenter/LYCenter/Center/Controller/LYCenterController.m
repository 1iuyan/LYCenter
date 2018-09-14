//
//  LYCenterController.m
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import "LYCenterController.h"
#import "LYCenterNavView.h"
#import "LYCenterTableView.h"
#import "LYCenterContainerCell.h"
#import "LYCenterHeaderView.h"
#import "LYCenterTitleView.h"

@interface LYCenterController ()<UITableViewDelegate, UITableViewDataSource, LYCenterContainerCellDelegate>
// 导航
@property (nonatomic, strong) LYCenterNavView *navView;
// header
@property (nonatomic, strong) LYCenterHeaderView *headerView;
// titleView
@property (nonatomic, strong) LYCenterTitleView *titleView;
// 主界面 tableView
@property (nonatomic, strong) LYCenterTableView *tableView;
// container
@property (nonatomic, strong) LYCenterContainerCell *contentCell;
// 是否能滑动 YES:能  NO:不能
@property (nonatomic, assign) BOOL canScroll;
// 是否应该刷新
@property (nonatomic, assign) BOOL shouldRefresh;
// 是否在刷新
@property (nonatomic, assign) BOOL isRefreshing;
// 偏移量
@property (nonatomic, assign) NSInteger lastContentOffY;
@end

@implementation LYCenterController
#pragma cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self uiconfig];
    [self addNotification];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    __weak __typeof(self)weakSelf = self;
    [self.tableView loadHeaderRefreshWithHeaderRefreshingBlock:^{
        [weakSelf.contentCell ly_refresh];
    }];
    [self.tableView beginHeaderRefresh];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
} 

#pragma mark uiconfig
- (void)uiconfig {
    self.canScroll = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.navView];
    self.tableView.showsVerticalScrollIndicator = NO;
    [LYCenterContainerCell regisCellForTableView:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
}

-(void)addNotification{
    // 通知的处理
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPageViewCtrlChange:) name:@"CenterPageViewScroll" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onOtherScrollToTop:) name:@"kLeaveTopNtf" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onScrollBottomView:) name:@"PageViewGestureState" object:nil];
}

/// 通知的处理
// pageViewController页面变动时的通知
- (void)onPageViewCtrlChange:(NSNotification *)notification {
    [self.titleView setCurrentTitleIndex:[notification.object integerValue]];
}

// 子控制器到顶部了 主控制器可以滑动
- (void)onOtherScrollToTop:(NSNotification *)ntf {
    self.titleView.lineView.hidden = YES;
    self.canScroll = YES;
    self.contentCell.canScroll = NO;
}

// 当滑动下面的PageView时，当前要禁止滑动
- (void)onScrollBottomView:(NSNotification *)ntf {
    if ([ntf.object isEqualToString:@"ended"]) {
        // bottomView停止滑动了  当前页可以滑动
        self.tableView.scrollEnabled = YES;
    } else {
        // bottomView滑动了 当前页就禁止滑动
        self.tableView.scrollEnabled = NO;
    }
}

#pragma mark - YDLDynamicHomeContentCellDelegate
-(void)ly_contentViewCellDidRecieveFinishRefreshingNotificaiton:(LYCenterContainerCell *)cell{
    [self.tableView endRefreshWithIsNoMoreData:NO];
    self.isRefreshing = NO;
}


#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //要减去导航栏 状态栏 以及 sectionheader的高度
    return kScreecHeight - self.titleView.height - kNavgationBarHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    //sectionheader的高度，这是要放分段控件的
    return 71;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.titleView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.contentCell) {
        self.contentCell = [LYCenterContainerCell dequeueCellForTableView:tableView];
        self.contentCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentCell.delegate = self;
        self.contentCell.currentSelectedIndex = 0;
        [self.contentCell setPageView];
    }
    return self.contentCell;
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //计算导航栏的透明度
    CGFloat minAlphaOffset = 0;
    CGFloat maxAlphaOffset = kScreecWide  / 1.7 - kNavgationBarHeight;
    CGFloat offset = scrollView.contentOffset.y;
    CGFloat alpha = (offset - minAlphaOffset) / (maxAlphaOffset - minAlphaOffset);
    NSLog(@"alpha--%f",alpha);
    self.navView.alpha = alpha;
    
    //子控制器和主控制器之间的滑动状态切换
    CGFloat tabOffsetY = [_tableView rectForSection:0].origin.y - kNavgationBarHeight;
    if (scrollView.contentOffset.y >= tabOffsetY) {
        scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        if (_canScroll) {
            _canScroll = NO;
            self.contentCell.canScroll = YES;
            self.titleView.lineView.hidden = NO;
        }
    } else {
        if (!_canScroll) {
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
        }
    }
    
    [self configRefreshStateWithScrollView:scrollView];
}

-(void)configRefreshStateWithScrollView:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y <= -kNavgationBarHeight && scrollView.contentOffset.y < self.lastContentOffY) {
        self.shouldRefresh = YES;
    }else{
        self.shouldRefresh = NO;
    }

    self.lastContentOffY = scrollView.contentOffset.y;
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.shouldRefresh && !self.isRefreshing) {
        [self.contentCell ly_refresh];
        self.isRefreshing  = YES;
    }else if(!self.isRefreshing){
        self.isRefreshing = NO;
    }
}


#pragma mark getter
- (LYCenterTableView *)tableView {
    if (!_tableView) {
        _tableView = [[LYCenterTableView alloc] initWithFrame:CGRectMake(0, 0, kScreecWide, kScreecHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (LYCenterNavView *)navView {
    if (!_navView) {
        _navView = [[LYCenterNavView alloc] init];
    }
    return _navView;
}

- (LYCenterHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[LYCenterHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreecWide, ceil(kScreecWide * 160 / 375) + 157 * (kScreecWide - 30) / 345 + 135 + 13)];
    }
    return _headerView;
}

- (LYCenterTitleView *)titleView {
    if (!_titleView) {
        _titleView = [[LYCenterTitleView alloc] initWithFrame:CGRectMake(0, ceil(kScreecWide * 160 / 375) + 157 * (kScreecWide - 30) / 345 + 135 + 13, kScreecWide, 71) titles:@[@"推荐", @"热门", @"关注"]];
        __weak __typeof(self)weakSelf = self;
        _titleView.didTitleClick = ^(NSInteger index) {
            weakSelf.contentCell.selectIndex = index;
        };
    }
    return _titleView;
}




@end
