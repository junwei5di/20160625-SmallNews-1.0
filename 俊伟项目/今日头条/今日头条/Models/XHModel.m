//
//  XHModel.m
//  今日头条
//
//  Created by qingyun on 16/6/14.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import "XHModel.h"

@implementation XHModel
+(instancetype)modelWithDictionary:(NSDictionary *)dict{
    return [[self alloc] initWithDictionary:dict];
}
-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self=[super init]) {
        _xhid=[dict[@"xhid"] integerValue];
        _author=dict[@"author"];
        _content=dict[@"content"];
        _picUrl=dict[@"picUrl"];
    }
    return self;
}
@end
