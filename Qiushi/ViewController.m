//
//  ViewController.m
//  Qiushi
//
//  Created by xingjiehai on 15/6/16.
//  Copyright (c) 2015年 xingjiehai. All rights reserved.
//

#import "ViewController.h"
#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "QiushiModel.h"
#import "QiushiCell.h"
#import <UIImageView+AFNetworking.h>

static NSString * const QiushiCellIdentifier = @"QiushiCell";
@interface ViewController (){
    NSMutableArray *_qiushiArr;
}
@property (weak, nonatomic) IBOutlet UITableView *JTableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.JTableView.delegate = self;
    self.JTableView.dataSource =self;
    [self prepareData];
}


- (void)prepareData{
    _qiushiArr = [[NSMutableArray alloc] init];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:@"http://m2.qiushibaike.com/article/list/suggest?count=30&page=1" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"JSON: %@", responseObject);
        NSDictionary *dic = (NSDictionary *)responseObject;
        NSArray *arr = [dic objectForKey:@"items"];
        for (NSDictionary *d in arr) {
            QiushiModel *model = [[QiushiModel alloc] init];
            [model configWithDictionary:d];
            [_qiushiArr addObject:model];
            NSLog(@"Arr: %@", _qiushiArr);
            [self.JTableView reloadData];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    
    
    

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (QiushiCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    QiushiCell *cell = [self.JTableView dequeueReusableCellWithIdentifier:QiushiCellIdentifier forIndexPath:indexPath];
    QiushiModel *model = _qiushiArr[indexPath.row];
    [self configureQiushiCell:cell atIndexPath:indexPath];
    [cell.authorImage setImageWithURL:[NSURL URLWithString:model.authorImageURl]];
    return cell;
}

- (void)configureQiushiCell:(QiushiCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    QiushiModel *model = _qiushiArr[indexPath.row];
    //[cell.authorImage setImageWithURL:[NSURL URLWithString:model.authorImageURl]];
    cell.authorName.text = model.author;
    cell.content.text = model.content;
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRows");
    return _qiushiArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForQiushiCellAtIndexPath:indexPath];
}

- (CGFloat)heightForQiushiCellAtIndexPath:(NSIndexPath *)indexPath {
    static QiushiCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.JTableView dequeueReusableCellWithIdentifier:QiushiCellIdentifier];
    });
    
    [self configureQiushiCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + 1.0f; // Add 1.0f for the cell separator height
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110.0f;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
