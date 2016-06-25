//
//  XHTabelCell.m
//  今日头条
//
//  Created by qingyun on 16/6/14.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "XHTabelCell.h"
#import "XHModel.h"
#import "masonry.h"
@interface XHTabelCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentlabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@end

@implementation XHTabelCell

-(void)setXhModel:(XHModel *)xhModel{
    _xhModel=xhModel;
    _contentlabel.text=xhModel.content;
    _authorLabel.text=xhModel.author;
    NSString *url=xhModel.picUrl;
    if (url.length>0) {
        [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(150, 100));
        }];
        [_iconView sd_setImageWithURL:[NSURL URLWithString:url]];
    }else{
        _iconView.image=nil;
        [_iconView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(0, 0));
        }];
    }
}

-(void)setXhColor:(UIColor *)xhColor{
    _xhColor=xhColor;
    _contentlabel.textColor=_authorLabel.textColor=xhColor;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
