//
//  SqlCreatTool.m
//  今日头条
//
//  Created by qingyun on 16/6/22.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <FMDB.h>
#import "SqlCreatTool.h"
#import "NewsModel.h"
#import "XHModel.h"
#import "Header.h"

@interface SqlCreatTool ()
@property(nonatomic,strong)FMDatabase *base;
@end

@implementation SqlCreatTool

-(FMDatabase *)base{
    if (_base==nil) {
        _base=[FMDatabase databaseWithPath:[self createSqlFile]];
    }
    return _base;
}

-(NSString *)createSqlFile{
    NSString *docPath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath=[docPath stringByAppendingPathComponent:SQLFILE];
    return filePath;
}

+(instancetype)shareSqlTool{
    static SqlCreatTool *sqlTool;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sqlTool=[[SqlCreatTool alloc] init];
        if ([sqlTool.base open]) {
//        NSLog(@"数据库创建成功,路径%@",[sqlTool createSqlFile]);
        }
    });
    return sqlTool;
}


-(BOOL)updateTableWithSqlStr:(NSString *)sql andModel:(id)model{
    BOOL result=YES;
    if ([sql containsString:@"delete"]&&model) {
        if ([model isKindOfClass:[XHModel class]]) {
            XHModel *xhModel=(XHModel *)model;
            result=[self.base executeUpdate:sql,@(xhModel.xhid)];
        }else if([model isKindOfClass:[NewsModel class]]){
            NewsModel *newModel=(NewsModel *)model;
            result=[self.base executeUpdate:sql,@(newModel.group_id)];
        }
    }else if (model) {
        if ([model isKindOfClass:[XHModel class]]) {
            XHModel *xhModel=(XHModel *)model;
            result=[self.base executeUpdate:sql,@(xhModel.xhid),xhModel.author,xhModel.content,xhModel.picUrl];
        }else if([model isKindOfClass:[NewsModel class]]){
            NewsModel *newModel=(NewsModel *)model;
            
            result=[self.base executeUpdate:sql,newModel.title,newModel.source,newModel.article_url,@(newModel.digg_count),@(newModel.behot_time),@(newModel.bury_count),@(newModel.repin_count),@(newModel.group_id)];
        }
    }else{
        result=[self.base executeUpdate:sql];
    }
    
    return result;
}
-(NSMutableArray *)selectTableWithSqlStr:(NSString *)sql andModel:(NSString *)modelName{
    FMResultSet *result=[self.base executeQuery:sql];
    NSMutableArray *mulArr=[NSMutableArray array];
    while ([result next]) {
        if ([modelName isEqualToString:NSStringFromClass([XHModel class])]) {
            XHModel *xhModel=[XHModel modelWithDictionary:[result resultDictionary]];
            [mulArr addObject:xhModel];
        }else if([modelName isEqualToString:NSStringFromClass([NewsModel class])]){
            NewsModel *neModel=[NewsModel modelWithDictionary:[result resultDictionary]];
            [mulArr addObject:neModel];
        }
    }
    return mulArr;
}


@end
