//
//  Header.h
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//



#ifndef Header_h
#define Header_h

#define NOTIFICATIONNAME @"tongzhi"
#define ZScreenX [UIScreen mainScreen].bounds.size.height
#define ZScreenY [UIScreen mainScreen].bounds.size.width
#define BASEURL @"http://api.1-blog.com/biz/bizserver/xiaohua/list.do"
#define DetailURL @"http://api.1-blog.com/biz/bizserver/xiaohua/detail.do"
#define XWBASEURL @"http://api.1-blog.com/biz/bizserver/news/list.do"

#define SQLFILE @"content.db"

#pragma mark SQL语言

/*
 @property(nonatomic,strong)NSString *title;
 @property(nonatomic,strong)NSString *source;
 @property(nonatomic,strong)NSString *article_url;
 @property(nonatomic)       NSInteger digg_count;
 @property(nonatomic)       NSInteger behot_time;
 @property(nonatomic)       NSInteger bury_count;
 @property(nonatomic)       NSInteger repin_count;
 @property(nonatomic)       NSInteger group_id;
 */
#pragma mark 创建表
#define CREATESQLNEWS @"create table if not exists newsSql(title text,source text,article_url text,digg_count integer,behot_time integer,bury_count integer,repin_count integer,group_id integer);"
/*
 @property(nonatomic,assign)NSInteger xhid;
 @property(nonatomic,strong)NSString *author;
 @property(nonatomic,strong)NSString *content;
 @property(nonatomic,strong)NSString *picUrl;
 */
#define CREATSQLXH @"create table if not exists xiaohua(xhid integer,author text,content text,picUrl text);"

#define CREATSQLFAV @"create table if not exists favourite(xhid integer primary key,author text,content text,picUrl text);"

#pragma mark 插入数据
#define INSERTSQLNEWS @"insert into newsSql(title,source,article_url,digg_count,behot_time,bury_count,repin_count,group_id)values(?,?,?,?,?,?,?,?);"
#define INSERTSQLXH @"insert into xiaohua(xhid,author,content,picUrl)values(?,?,?,?);"

#define INSERTSQLFAV @"insert into favourite(xhid,author,content,picUrl)values(?,?,?,?);"


#pragma mark 删除内容
#define DELETESQLNEWS @"delete from newsSql where group_id=?;"

#define DELETESQLXH @"delete from xiaohua where xhid=?;"

#define DELETESQLFAV @"delete from favourite where xhid=?;"

#pragma mark 搜索内容
#define SELECTSQLNEWS @"select *from newsSql where group_id=?;"
#define SELECTSQLXH @"select *from xiaohua where xhid=?;"

#define SELECTSQLFAV @"select *from favourite;"

#pragma mark 删除表格(清空缓存)

#define DROPSQLXH @"delete from xiaohua;"

#define DROPSQLNEWS @"delete from newsSql;"

#define DROPSQLFAV @"delete from favourite;"

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

static NSString const *XWTitle=@"title";
static NSString const *XWSource=@"source";
static NSString const *XWArticle_Url=@"article_url";
static NSString const *XWBehot_Time=@"behot_time";
static NSString const *XWDigg_Count=@"digg_count";
static NSString const *XWBury_Count=@"bury_count";
static NSString const *XWRepin_Count=@"repin_count";
static NSString const *XWGroup_Id=@"group_id";
#endif /* Header_h */