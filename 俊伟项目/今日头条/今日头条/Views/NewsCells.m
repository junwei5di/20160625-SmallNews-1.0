//
//  NewsCells.m
//  今日头条
//
//  Created by qingyun on 16/6/20.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <Masonry.h>
#import "NewsCells.h"
#import "NewsModel.h"

@interface NewsCells ()
@property (weak, nonatomic) IBOutlet UILabel *titleText;
@property (weak, nonatomic) IBOutlet UILabel *sourceText;
@property (weak, nonatomic) IBOutlet UILabel *contentText;
@end

@implementation NewsCells


-(void)setNModel:(NewsModel *)nModel{
    _nModel=nModel;
    _titleText.text=nModel.title;
    _sourceText.text=nModel.source;
    if (nModel.article_url) {
        _contentText.text=@"点击查看详情";
    }
}

-(void)setNColor:(UIColor *)nColor{
    _nColor=nColor;
    _titleText.textColor=_sourceText.textColor=_contentText.textColor=nColor;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
