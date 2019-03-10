//
//  DYZRequestObject.m
//  DayuDoctor
//
//  Created by 赵学良 on 2019/3/7.
//  Copyright © 2019年 大禹中医. All rights reserved.
//

#import "DYZRequestObject.h"
#import "AppDelegate.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface DYZRequestObject()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, assign) BOOL isError;

@end

@implementation DYZRequestObject


- (void)startPostWithSuccessBlock:(LYRequestSuccessBlock)success failBlock:(LYRequestFailBlock)fail {
    
    __weak typeof(self) weakSelf = self;
    [super startPostWithSuccessBlock:^(id responseObject, NSDictionary *options) {
        
        if ([responseObject isKindOfClass:[LYResponseObject class]]) {
            LYResponseObject *response = (LYResponseObject *)responseObject;
            if (response.resultcode.integerValue == 0) {
                if (self.noResultView) {
                    id container = response.resultDict[@"content"];
                    if (!container) {
                        container = response.resultDict[@"list"];
                    }
                    if ([container isKindOfClass:[NSArray class]]) {
                        NSArray *content = (NSArray *)container;
                        if (content.count < 20) { //没有更多数据
                            [self showNoMoreDataFooter];
                        }
                        
                        if (self.dataSource.count == 0) {//没有数据
                            _isError = NO;
                            [self showNoMoreDataView];
                        }
                    }
                }
                success(responseObject, options);
            } else {
                if (self.noResultView) {
                    _isError = YES;
                    [self showNoMoreDataView];
                } else {
                    LYNetworkError *customError = [LYErrorConfig networkError:nil rspCode:response.resultcode.integerValue];
                    fail(customError, nil);
                }
            }
            [self endRefreshing];
        } else {
            success(responseObject, options);
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        fail(error,options);
//        if (self.noResultView) {
//            _isError = YES;
//            [self endRefreshing];
////            [self showNoMoreDataView];
//        } else {
//        }
        [weakSelf showErrorDescription:error.description];
    }];
    
}

- (void)showNoMoreDataFooter {
    if ([self.noResultView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrolllView = (UIScrollView *)self.noResultView;
        scrolllView.mj_footer.state = MJRefreshStateNoMoreData;
    }
}

- (void)showNoMoreDataView {
    if ([self.noResultView isKindOfClass:[UIScrollView class]]) {
        UIScrollView *scrolllView = (UIScrollView *)self.noResultView;
        scrolllView.emptyDataSetSource = self;
        scrolllView.emptyDataSetDelegate = self;
        [scrolllView reloadEmptyDataSet];
    }
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)endRefreshing {
    if (self.noResultView) {
        if ([self.noResultView isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrolllView = (UIScrollView *)self.noResultView;
            if (scrolllView.mj_header.isRefreshing) {
                [scrolllView.mj_header endRefreshing];
            }
            if (scrolllView.mj_footer.isRefreshing) {
                if (scrolllView.mj_footer.state == MJRefreshStateNoMoreData) {
                    [scrolllView.mj_footer endRefreshingWithNoMoreData];
                } else {
                    [scrolllView.mj_footer endRefreshing];
                }
            }
        }
    }
}


- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    UIView *view = [UIView new];
    [scrollView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
//    if (_isError) {
//        view.backgroundColor = [UIColor redColor];
//    } else {
//        view.backgroundColor = [UIColor greenColor];
//    }
    UIImage *image = [UIImage imageNamed:@"icon_noresult.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.size.mas_equalTo(image.size);
    }];
    
    return view;
}



- (void)showErrorDescription:(NSString *)description {
    UIWindow *window = ((AppDelegate*)([UIApplication sharedApplication].delegate)).window;
    [window makeToast:description];
}

@end
