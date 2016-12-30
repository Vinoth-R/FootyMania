//
//  NewsFeedsVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 11/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsFeedsVc : UIViewController <NSXMLParserDelegate, UIGestureRecognizerDelegate, CAAnimationDelegate, UIWebViewDelegate>
{

 
    NSXMLParser     *parser;
    NSMutableArray  *feeds;
    NSMutableString *description;
    NSMutableString *thumbnail;
    NSMutableString *pubdate;
    NSMutableString *link;
    NSMutableArray *mutLinkArray;
    NSMutableString *images;
    NSMutableString *content;
    NSString *element;
    NSMutableDictionary *item;
    UIImageView *imgV;
}
@property (strong, nonatomic) IBOutlet UITableView *table_view;
@end
