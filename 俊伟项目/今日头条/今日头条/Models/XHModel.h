//
//  XHModel.h
//  今日头条
//
//  Created by qingyun on 16/6/14.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
“xhid”: “90851”, —-笑话id，判断笑话新旧用的
“author”: “xxx”, —-笑话作者
“content”: “xxx”, —-笑话内容
“picUrl”: “”, —-笑话的图片（如果有）
 */
@interface XHModel : NSObject

@property(nonatomic,assign)NSInteger xhid;
@property(nonatomic,strong)NSString *author;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *picUrl;

+(instancetype)modelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
