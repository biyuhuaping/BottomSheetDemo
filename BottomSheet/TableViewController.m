//
//  TableViewController.m
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import "TableViewController.h"

static CGFloat const maxVisibleContentHeight = 400.0;
static NSInteger const numberOfCountries = 20;
static NSString *const reuseIdentifier = @"cell";

@interface TableViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<NSString *> *countries;
//@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.clearColor;
    
//    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 150)];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(maxVisibleContentHeight, 0, 0, 0);
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
    self.tableView.layer.maskedCorners = kCALayerMinXMinYCorner | kCALayerMaxXMinYCorner;
//    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.delegate bottomSheet:self didScrollTo:self.tableView.contentOffset];
    
    if (self.tableView.contentSize.height < self.tableView.bounds.size.height) {
        self.tableView.contentSize = CGSizeMake(self.tableView.contentSize.width, self.tableView.bounds.size.height);
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"row: %ld", (long)indexPath.row];
    cell.backgroundColor = UIColor.clearColor;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Scroll view delegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    CGFloat targetOffset = targetContentOffset->y;
    CGFloat pulledUpOffset = 0;
    CGFloat pulledDownOffset = -maxVisibleContentHeight;
    
//    if (scrollView.contentOffset.y < -420) {
//        targetContentOffset->y = -800;
//        return;
//    }
    
    if (targetOffset >= pulledDownOffset && targetOffset <= pulledUpOffset) {
        if (velocity.y < 0) {
            targetContentOffset->y = pulledDownOffset;
        } else {
            targetContentOffset->y = pulledUpOffset;
        }
    }
}

@end
