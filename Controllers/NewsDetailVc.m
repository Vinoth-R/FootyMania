//
//  NewsDetailVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 11/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "NewsDetailVc.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsDetailVc ()
{
IBOutlet UIActivityIndicatorView *spinner;
}
@end

@implementation NewsDetailVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.title = @"News Description";

//    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.frame = CGRectMake(0, 0 , 10, 10);
//    [_imgView addSubview:spinner];
        [spinner startAnimating];
    
    NSString *StrCrop = [_imgStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *imgStrCrop = [StrCrop stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
     dispatch_async(dispatch_get_main_queue(), ^{
    [_imgView sd_setImageWithURL:[NSURL URLWithString:imgStrCrop] placeholderImage:[UIImage imageNamed: @""] options:SDWebImageHighPriority];
   NSString *width = @"320";
    NSString *heigth = @"480";
   _newsStr =   [_newsStr stringByReplacingOccurrencesOfString:@"width=" withString:[NSString stringWithFormat:@"width=%@",width]];
    _newsStr =  [_newsStr stringByReplacingOccurrencesOfString:@"height=" withString:[NSString stringWithFormat:@"heigth=%@",heigth]];
   
    [_webView loadHTMLString:_newsStr baseURL:nil];
    [spinner stopAnimating];
     }
                    );

}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [webView.scrollView setContentSize: CGSizeMake(webView.frame.size.width, webView.scrollView.contentSize.height)];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
