//
//  ZBChangeNetWorkSheetView.m
//  goodLook
//
//  Created by ZB on 2024/1/3.
//

#import "ZBChangeNetWorkSheetView.h"
#import "ZBChangeNetWorkCell.h"
#import <Masonry.h>

#define scrollHeight 240 + kBottomSafeHeight

@interface ZBChangeNetWorkSheetView ()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIControl *maskView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentViews;

@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIButton *doneBtn;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) NSArray *dataArray;
@property (nonatomic, copy) NSArray *detailArray;
@property (assign, nonatomic) NSIndexPath *selIndex;      //单选选中的行

@end

@implementation ZBChangeNetWorkSheetView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(self.frame.origin.x, kScreenH, kScreenW, self.frame.size.height);
        self.backgroundColor = UIColor.clearColor;
        NSInteger indx = 0;
        self.selIndex = [NSIndexPath indexPathForRow:indx inSection:0];
        self.dataArray = @[@"测试环境", @"正式环境"];
        self.detailArray = @[@"https://api-test.crazeid.com", @"https://neptune.crazeid.com"];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self.maskView];
    [self.maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.trailing.leading.equalTo(window);
    }];
    [self.maskView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.bottom.trailing.equalTo(self.maskView);
//        make.top.equalTo(self.maskView.mas_bottom).offset(-200 -200 -kBottomSafeHeight);
        make.top.equalTo(self.maskView.mas_bottom);
    }];
    
    //scrollView
    self.scrollView = ({
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.delegate = self;
        scrollView.backgroundColor = UIColor.clearColor;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.layer.cornerRadius = 10;
        scrollView.alwaysBounceVertical = NO;
        scrollView;
    });
    [self addSubview:self.scrollView];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //contentViews
    self.contentViews = ({
        UIView *aView = [[UIView alloc] init];
        aView.backgroundColor = UIColor.whiteColor;
        aView.layer.cornerRadius = 25;
        aView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
        aView;
    });
    [self.scrollView addSubview:self.contentViews];
    [self.contentViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(scrollHeight);
    }];
    
    
    [self.contentViews addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.leading.mas_equalTo(18);
        make.height.mas_equalTo(44);
    }];
    
    [self.contentViews addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLab.mas_bottom).offset(5);
        make.leading.mas_equalTo(18);
        make.trailing.mas_equalTo(-18);
    }];
    
    [self.contentViews addSubview:self.doneBtn];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tableView.mas_bottom).offset(5);
        make.leading.mas_equalTo(18);
        make.trailing.mas_equalTo(-18);
        make.bottom.mas_equalTo(self.contentViews).offset(-30 -kBottomSafeHeight);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZBChangeNetWorkCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZBChangeNetWorkCell"];
    cell.titleLab.text = self.dataArray[indexPath.row];
    cell.detailLab.text = self.detailArray[indexPath.row];
    if (self.selIndex == indexPath) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    cell.imageView.backgroundColor = UIColor.greenColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消之前的选择
    UITableViewCell *celled = [tableView cellForRowAtIndexPath:self.selIndex];
    celled.accessoryType = UITableViewCellAccessoryNone;

    //记录当前的选择的位置
    self.selIndex = indexPath;
    
    //当前选择的打钩
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

#pragma mark - UIScrollView
//此处是scrollview不允许向上滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if ([scrollView isEqual:self.scrollView]) {
        if (scrollView.contentOffset.y > 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
        }
    }else{
        if (scrollView.contentOffset.y <= 0) {
            scrollView.contentOffset = CGPointMake(0, 0);
            self.scrollView.alwaysBounceVertical = true;
        }else{
            self.scrollView.alwaysBounceVertical = false;
//            self.topLineView.hidden = NO;
        }
    }
}

//此处是scrollview向下滑动超过50则关闭视图
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    NSLog(@"scrollView.contentOffset.y:%.2f",scrollView.contentOffset.y);
    if (scrollView.contentOffset.y <= -50) {
        [self hideView];
    }
}

#pragma mark -
- (void)showView {
    CGFloat height = scrollHeight;
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.frame = CGRectMake(self.frame.origin.x, kScreenH-height, kScreenW, height);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.maskView.mas_bottom).offset(-height);
        }];
    }];
}

- (void)hideView {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    [UIView animateWithDuration:0.25 animations:^{
        self.maskView.alpha = 0.0;
        self.frame = CGRectMake(self.frame.origin.x, kScreenH, self.frame.size.width, self.frame.size.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [self.maskView removeFromSuperview];
        self.maskView = nil;
    }];
}

- (void)doneButtonAction{
    [self hideView];
}

#pragma mark - lazy
- (UIControl *)maskView {
    if (!_maskView) {
        _maskView = [[UIControl alloc] initWithFrame:kScreenBounds];
        _maskView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        [_maskView addTarget:self action:@selector(hideView) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maskView;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.text = @"选择网络环境";
    }
    return _titleLab;
}

- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.separatorStyle = UITableViewCellSeparatorStyleNone;
        table.delegate = self;
        table.dataSource = self;
        table.backgroundColor = UIColor.whiteColor;
        table.estimatedRowHeight = 44;
        table.sectionHeaderHeight = 0.01;
        [table registerClass:ZBChangeNetWorkCell.class forCellReuseIdentifier:@"ZBChangeNetWorkCell"];
        table.tableFooterView = [[UIView alloc]init];
        if (@available(iOS 15.0, *)) {
            table.sectionHeaderTopPadding = 0.0;
        } else {
            // Fallback on earlier versions
        }
        _tableView = table;
    }
    return _tableView;
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = UIColor.systemBlueColor;
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:@"确定" forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(doneButtonAction) forControlEvents:UIControlEventTouchUpInside];
        btn.layer.cornerRadius = 22;
        _doneBtn = btn;
    }
    return _doneBtn;
}

- (void)dealloc{
    
}

@end
