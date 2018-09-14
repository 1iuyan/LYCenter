//
//  LYCenterBaseViewController.h
//  LYCenter
//
//  Created by liuyan on 2018/9/14.
//  Copyright © 2018年 liuyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYCenterBaseViewController;

@protocol LYCenterBaseViewControllerDelegate <NSObject>

- (void)ly_viewControllerDidFinishRefreshing:(LYCenterBaseViewController *)viewController;

@end

@interface LYCenterBaseViewController : UIViewController

- (instancetype)initWithType:(NSString *)type;

@property (nonatomic, assign) BOOL canScroll;

@property (nonatomic, assign) BOOL isRefreshing;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, weak) id<LYCenterBaseViewControllerDelegate> delegate;

-(void)ly_refresh;

@end
