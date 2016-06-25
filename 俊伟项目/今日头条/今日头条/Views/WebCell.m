//
//  WebCell.m
//  今日头条
//
//  Created by qingyun on 16/6/21.
//  Copyright © 2016年 zhou.. All rights reserved.
//

#import <SVProgressHUD.h>
#import "WebCell.h"



@interface WebCell ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webLoadView;
@end

@implementation WebCell

-(void)setUrl:(NSString *)url{
    _url=url;
    if (url) {
        _webLoadView.delegate=self;
        NSURL *baseUrl=[NSURL URLWithString:url];
        NSURLRequest *request=[NSURLRequest requestWithURL:baseUrl];
        [SVProgressHUD show];
        [_webLoadView loadRequest:request];
    }
}

-(void)setTeColor:(UIColor *)teColor{
    _teColor=teColor;
    _webLoadView.backgroundColor=teColor;
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"%@",error]];
    [SVProgressHUD dismissWithDelay:2];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
