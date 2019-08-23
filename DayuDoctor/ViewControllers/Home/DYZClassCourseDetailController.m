//
//  DYZClassCourseDetailController.m
//  DayuDoctor
//
//  Created by zhuopin on 2019/6/8.
//  Copyright © 2019 大禹中医. All rights reserved.
//

#import "DYZClassCourseDetailController.h"
#import "UIImage+DYZAdd.h"
#import "APICourseDetail.h"
#import "DYZClassCourseDetailCell.h"
#import "APICourseItem.h"
#import "PlayerViewController.h"
#import "APICollectCourse.h"
#import "APIDeleteCollection.h"

@interface DYZClassCourseDetailController ()<UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *container;

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UIScrollView *bottomScrollView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) APICourseDetail *request;
@property (nonatomic, strong) APICourseItem *itemRequest;

@property (nonatomic, strong) ResponseCourseItem *itemResponse;

@property (nonatomic, strong) UILabel *lblDetail;
@property (nonatomic, strong) UIView *bottomBgView;


@property (nonatomic, strong) UIButton *collecBtn;
@property (nonatomic, strong) UIButton *buyBtn;
@property (nonatomic, copy) NSString *detailInfo;
@property (nonatomic, strong) NSArray *imageArray;


@end

@implementation DYZClassCourseDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _course.title;
    
    [self _initScrollViewWithContainer];
    [self setupView];
    
    _request = [APICourseDetail new];
    _request.id = _course.cid;
    [_request startPostWithSuccessBlock:^(ResponseCourseDetail *course, NSDictionary *options) {
        
        self.detailInfo = course.detail.details;
        
        [self reloadView];
        if ([course.detail.follow isEqualToString:@"true"]) {
            _collecBtn.selected = YES;
        } else {
            _collecBtn.selected = NO;
        }
        
        if ([course.detail.buy isEqualToString:@"true"]) {
            _buyBtn.selected = YES;
        } else {
            _buyBtn.selected = NO;
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
    
    _itemRequest = [APICourseItem new];
    _itemRequest.id = _course.cid;
    [_itemRequest startPostWithSuccessBlock:^(ResponseCourseItem *response, NSDictionary *options) {
        _itemResponse = response;
        [_tableView reloadData];
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)reloadView {
    NSString *detail = [self filterHTML:_detailInfo];
    self.lblDetail.text = detail;
    CGFloat height = [detail sizeForFont:_lblDetail.font size:CGSizeMake(CGRectGetWidth(self.view.frame)-32, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping].height;
    [self.lblDetail mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    
    if (!detail.length) {
        self.imageArray = [self getImageurlFromHtml:_detailInfo];

        CGFloat margin = 200;
        CGFloat totalHeight = _imageArray.count * margin;
        for (int i = 0; i < _imageArray.count; i++) {
            NSString *url = _imageArray[i];
            UIImageView *imageView = [UIImageView new];
            [self.container addSubview:imageView];
            [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_leftButton.mas_bottom).offset(i*margin+10);
                make.left.right.equalTo(_container);
                make.height.mas_equalTo(margin);
            }];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (image) {
                    CGFloat height = _container.width  * (image.size.height/image.size.width);
                    [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(height);
                    }];
                    [self.lblDetail mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.height.mas_equalTo(totalHeight+(height-margin));
                    }];
                    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.bottom.equalTo(_lblDetail.mas_bottom).mas_offset(10);
                    }];
                }
            }];
        }
        [self.lblDetail mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(_imageArray.count * 200);
        }];
    }
}

- (NSArray *) getImageurlFromHtml:(NSString *) webString
{
    NSMutableArray * imageurlArray = [NSMutableArray arrayWithCapacity:1];
    
    //标签匹配
   NSString *parten = @"<img(.*?)>";
   NSError* error = NULL;
   NSRegularExpression *reg = [NSRegularExpression regularExpressionWithPattern:parten options:0 error:&error];
   NSArray* match = [reg matchesInString:webString options:0 range:NSMakeRange(0, [webString length] - 1)];
   
       for (NSTextCheckingResult * result in match) {
                  
      //过去数组中的标签
      NSRange range = [result range];
      NSString * subString = [webString substringWithRange:range];
                  

      //从图片中的标签中提取ImageURL
      NSRegularExpression *subReg = [NSRegularExpression regularExpressionWithPattern:@"http://(.*?)\"" options:0 error:NULL];
      NSArray* match = [subReg matchesInString:subString options:0 range:NSMakeRange(0, [subString length] - 1)];
      NSTextCheckingResult * subRes = match[0];
        NSRange subRange = [subRes range];
        subRange.length = subRange.length -1;
        NSString * imagekUrl = [subString substringWithRange:subRange];
                   
        //将提取出的图片URL添加到图片数组中
        [imageurlArray addObject:imagekUrl];
    }
   
    return imageurlArray;
}


-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

- (void)_initScrollViewWithContainer {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.alwaysBounceVertical = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
    [self.view addSubview:scrollView];
    
    CGFloat bottom = 50;
    if (IS_IPHONE_X) {
        bottom += 34;
    }
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, bottom, 0));
    }];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, scrollView);
    _scrollView = scrollView;
    
    UIView *container = [UIView new];
    [scrollView addSubview:container];
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    _container = container;
}

- (void)setupView {
    _imageView = [UIImageView new];
    [_container addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(SCREEN_WIDTH * 0.6);
    }];
    NSURL *imageUrl = [NSURL URLWithString:_course.img];
    [_imageView sd_setImageWithURL:imageUrl];

    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [_container addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imageView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    titleLabel.text = _course.title;
    
    UILabel *subTitle = [UILabel new];
    subTitle.font = [UIFont systemFontOfSize:15];
    [_container addSubview:subTitle];
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    subTitle.text = [NSString stringWithFormat:@"主讲人：%@", _course.teacher];
    
    
    _leftButton = [self getButton:@"详情"];
    [_container addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subTitle.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH / 2);
        make.height.mas_equalTo(40);
    }];
    _leftButton.selected = YES;
    
    
    _rightButton = [self getButton:@"目录"];
    [_container addSubview:_rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(subTitle.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(SCREEN_WIDTH / 2);
        make.width.mas_equalTo(SCREEN_WIDTH / 2);
        make.height.mas_equalTo(40);
    }];

    
    _lblDetail = [UILabel new];
    _lblDetail.numberOfLines = 0;
    [_container addSubview:_lblDetail];

    [_lblDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftButton.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(50);
    }];
    
    [self setupTableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftButton.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(150);
    }];
    
    
    _bottomBgView = [UIView new];
    [self.view addSubview:_bottomBgView];
    _bottomBgView.layer.borderColor = [UIColor colorWithHexString:@"#d3d3d3"].CGColor;
    _bottomBgView.layer.borderWidth = 0.5;

    CGFloat bottom = 0;
    if (IS_IPHONE_X) {
        bottom += 34;
    }
    [_bottomBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(50);
        make.bottom.equalTo(self.view).mas_offset(-bottom);
    }];
    
    
    _collecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collecBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    _collecBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_collecBtn setImage:[UIImage imageNamed:@"33"] forState:UIControlStateNormal];
    [_collecBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_collecBtn setTitle:@"收藏" forState:UIControlStateNormal];
    [_collecBtn setTitle:@"已收藏" forState:UIControlStateSelected];
    [_bottomBgView addSubview:_collecBtn];
    [_collecBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomBgView);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    [_collecBtn addTarget:self
                   action:@selector(collecBtnActon:)
         forControlEvents:UIControlEventTouchUpInside];
    
    
    _buyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _buyBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_buyBtn setTitle:@"购买课程" forState:UIControlStateNormal];
    [_buyBtn setTitle:@"已购买" forState:UIControlStateSelected];
    [_bottomBgView addSubview:_buyBtn];
    [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bottomBgView);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
    _buyBtn.backgroundColor = [UIColor colorWithHexString:@"#3d170c"];
    _buyBtn.hidden = YES;
    [_buyBtn addTarget:self
                action:@selector(buyBtnActon:)
        forControlEvents:UIControlEventTouchUpInside];

    
    [_container mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_lblDetail.mas_bottom).mas_offset(10);
    }];
}

- (void)collecBtnActon:(UIButton *)button {
    if (button.selected) {
        [self unCollection];
    } else {
        [self collection];
    }
}

- (void)buyBtnActon:(UIButton *)button {
    if (button.selected == NO) {
        
    }
}

- (void)collection {
    APICollectCourse *course = [APICollectCourse new];
    course.courseId = _course.cid;
    [course startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        if ([responseObject.resultmsg isEqualToString:@"success"]) {
            _collecBtn.selected = YES;
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}

- (void)unCollection {
    APIDeleteCollection *deleteRequest = [APIDeleteCollection new];
    NSMutableArray *array = [NSMutableArray new];
    NSMutableArray *courses = [NSMutableArray new];
    [courses addObject:_course.cid];
    deleteRequest.courseId = array;
    
    [deleteRequest startPostWithSuccessBlock:^(ResponseCommon *responseObject, NSDictionary *options) {
        if ([responseObject.resultmsg isEqualToString:@"success"]) {
            _collecBtn.selected = NO;
        }
    } failBlock:^(LYNetworkError *error, NSDictionary *options) {
        
    }];
}


- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 40;
    [_container addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, -3);
    [_tableView registerClass:[DYZClassCourseDetailCell class] forCellReuseIdentifier:@"cell"];
    ADJUST_SCROLLVIEW_INSET_NEVER(self, self.tableView);
    _tableView.hidden = YES;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.scrollEnabled = NO;
}

- (void)buttonAction:(UIButton *)button {
    button.selected = YES;
    if (button == _leftButton) {
        _rightButton.selected = NO;
        _tableView.hidden = YES;
        _lblDetail.hidden = NO;
        
        [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(_lblDetail.mas_bottom).mas_offset(10);
        }];
    }
    
    if (button == _rightButton) {
        _leftButton.selected = NO;
        _lblDetail.hidden = YES;
        _tableView.hidden = NO;
        
        [_container mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView).insets(UIEdgeInsetsMake(0, 0, 0, 0));
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.bottom.equalTo(_tableView.mas_bottom).mas_offset(10);
        }];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _itemResponse.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PlayerViewController *vc = [PlayerViewController new];
    CourseItem *item = _itemResponse.items[indexPath.section];
    vc.onlineURL = item.ID;
    vc.videoName = item.name;
    vc.playMode = PlayerModeOnline;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        NSInteger count = _itemResponse.items.count;
        CGFloat height = count * 40 + (count - 1) * 10 + 5;
        make.height.mas_equalTo(height);
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZClassCourseDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (_itemResponse.items.count) {
        CourseItem *item = _itemResponse.items[indexPath.section];
        [cell setCourseItem:item];
    }
    return cell;
}

- (UIButton *)getButton:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor blackColor]
                 forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor]
                 forState:UIControlStateSelected];
    
    UIColor *normalStatus = [UIColor colorWithHexString:@"#FFFAFA"];
    UIColor *selectStatus = [UIColor colorWithHexString:@"#3d170c"];
    
    UIImage *norImg = [UIImage imageWithColor:normalStatus];
    UIImage *selImg = [UIImage imageWithColor:selectStatus];
    
    [button setBackgroundImage:norImg forState:UIControlStateNormal];
    [button setBackgroundImage:selImg forState:UIControlStateSelected];

    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    return button;
}

@end
