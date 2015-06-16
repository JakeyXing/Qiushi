//
//  QiushiModel.h
//  Qiushi
//
//  Created by xingjiehai on 15/6/16.
//  Copyright (c) 2015年 xingjiehai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiushiModel : NSObject
@property (nonatomic,strong) NSString *imageURL;
@property (nonatomic,strong) NSString *imageMidURL;
@property (nonatomic,strong) NSString *authorImageURl;
@property (nonatomic,strong) NSString *tag;
@property (nonatomic,strong) NSString *author;
@property (nonatomic,strong) NSString *authorID;
@property (nonatomic,strong) NSString *qiushiID;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,assign) NSTimeInterval published_at;
@property (nonatomic,assign) NSInteger commentsCount;
@property (nonatomic,assign) NSInteger downCount;
@property (nonatomic,assign) NSInteger upCount;

- (void)configWithDictionary:(NSDictionary *)dic;
@end
