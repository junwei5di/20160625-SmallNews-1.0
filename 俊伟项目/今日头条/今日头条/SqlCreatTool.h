//
//  SqlCreatTool.h
//  今日头条
//
//  Created by qingyun on 16/6/22.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SqlCreatTool : NSObject

+(instancetype)shareSqlTool;

-(BOOL)updateTableWithSqlStr:(NSString *)sql andModel:(id)model;
-(NSMutableArray *)selectTableWithSqlStr:(NSString *)sql andModel:(NSString *)modelName;

@end
