//
//  NewsDetailVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 11/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsDetailVc : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSString *newsStr;
@property (strong, nonatomic) NSString *imgStr;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@end
