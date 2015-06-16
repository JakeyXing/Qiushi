//
//  QiushiModel.m
//  Qiushi
//
//  Created by xingjiehai on 15/6/16.
//  Copyright (c) 2015年 xingjiehai. All rights reserved.
//

#import "QiushiModel.h"

@implementation QiushiModel

- (void)configWithDictionary:(NSDictionary *)dic{
    NSString *tagT = [dic objectForKey:@"tag"];
    if (tagT.length >0) {
        self.tag = tagT;
    }
    self.qiushiID = [dic objectForKey:@"id"];
    self.content = [dic objectForKey:@"content"];
    self.published_at = [[dic objectForKey:@"published_at"] doubleValue];
    self.commentsCount = [[dic objectForKey:@"comments_count"] integerValue];
    NSString *imageURLT = [dic objectForKey:@"image"];
    if (imageURLT != nil) {
        self.imageURL = imageURLT;
        NSString *prefixQiuShiID = [self.qiushiID substringWithRange:NSMakeRange(0, 4)];
        NSString *newImageURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/small/%@",prefixQiuShiID,self.qiushiID,self.imageURL];
        NSString *newImageMidURL = [NSString stringWithFormat:@"http://pic.moumentei.com/system/pictures/%@/%@/medium/%@",prefixQiuShiID,_qiushiID,_imageURL];
        self.imageURL = newImageURL;
        self.imageMidURL = newImageMidURL;
    }
    
    NSObject *user = [dic objectForKey:@"user"];
    if (user != [NSNull null]) {
        NSDictionary *users = (NSDictionary *)user;
        self.author = [users objectForKey:@"login"];
        self.authorID = [users objectForKey:@"id"];
        
        NSString *imageS = [users objectForKey:@"icon"];
        if (imageS != NULL) {
            self.authorImageURl = imageS;
        }
        
        if (self.authorID.length >3) {
            NSString *prefixAuthorID = [self.authorID substringWithRange:NSMakeRange(0, 3)];
            self.authorImageURl = [NSString stringWithFormat:@"http://pic.moumentei.com/system/avtnew/%@/%@/thumb/%@",prefixAuthorID,self.authorID,self.authorImageURl];
        }
    }
}

@end
