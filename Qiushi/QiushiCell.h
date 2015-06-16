//
//  QiushiCell.h
//  Qiushi
//
//  Created by xingjiehai on 15/6/16.
//  Copyright (c) 2015年 xingjiehai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QiushiCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end
