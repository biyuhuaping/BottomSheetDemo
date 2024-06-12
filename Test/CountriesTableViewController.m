//
//  CountriesTableViewController.m
//  Test
//
//  Created by ZB on 2024/6/11.
//

#import "CountriesTableViewController.h"

static CGFloat const maxVisibleContentHeight = 400.0;
static NSInteger const numberOfCountries = 20;
static NSString *const reuseIdentifier = @"cell";

@interface CountriesTableViewController ()

@property (nonatomic, strong) NSArray<NSString *> *countries;

@end

@implementation CountriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    self.tableView.contentInset = UIEdgeInsetsMake(maxVisibleContentHeight, 0, 0, 0);
    self.tableView.backgroundColor = UIColor.clearColor;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.decelerationRate = UIScrollViewDecelerationRateFast;
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
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.textLabel.text = @"112121";
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
    
    if (scrollView.contentOffset.y < -420) {
        targetContentOffset->y = -800;
        return;
    }
    
    if (targetOffset >= pulledDownOffset && targetOffset <= pulledUpOffset) {
        if (velocity.y < 0) {
            targetContentOffset->y = pulledDownOffset;
        } else {
            targetContentOffset->y = pulledUpOffset;
        }
    }
}

@end
