//
//  NewsModel.h
//  今日头条
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject
/*
 title”: “分享视频 “, —-新闻标题
 “source”: “微博视频”, —-新闻来源
 “article_url”: “xxx”, —-新闻的url地址
 “behot_time”: 1425185036000, —-新闻收录时间，以毫秒计数的整数
 “digg_count”: 1, —-赞的次数
 “bury_count”: 2015, —-踩的次数
 “repin_count”: 1, —-收藏次数
 “group_id”: “4006917770” —-新闻的id，无需关注
 */
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *source;
@property(nonatomic,strong)NSString *article_url;
@property(nonatomic)       NSInteger digg_count;
@property(nonatomic)       NSInteger behot_time;
@property(nonatomic)       NSInteger bury_count;
@property(nonatomic)       NSInteger repin_count;
@property(nonatomic)       NSInteger group_id;
-(instancetype)initWithDictionary:(NSDictionary *)newDict;
+(instancetype)modelWithDictionary:(NSDictionary *)newDict;
@end
