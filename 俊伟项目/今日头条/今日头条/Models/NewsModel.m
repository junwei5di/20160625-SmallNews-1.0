//
//  NewsModel.m
//  今日头条
//
//  Created by qingyun on 16/5/18.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "NewsModel.h"
#import "Header.h"
@implementation NewsModel
-(instancetype)initWithDictionary:(NSDictionary *)newDict{
    if (self=[super init]) {
        _title=newDict[XWTitle];
        _source=newDict[XWSource];
        _article_url=newDict[XWArticle_Url];
        _behot_time=[newDict[XWBehot_Time] integerValue];
        _digg_count=[newDict[XWDigg_Count] integerValue];
        _bury_count=[newDict[XWBury_Count] integerValue];
        _repin_count=[newDict[XWRepin_Count] integerValue];
        _group_id=[newDict[XWGroup_Id] integerValue];
    }
    return self;
}
+(instancetype)modelWithDictionary:(NSDictionary *)newDict{
    return [[self alloc] initWithDictionary:newDict];
}
@end
