//
//  TransferNewsVc.h
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 30/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransferNewsVc : UIViewController <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>
{
    NSXMLParser     *parser;
    NSMutableArray  *feeds;
    NSMutableString *description;
    NSMutableString *title;
    NSMutableString *thumbnail;
    NSMutableString *pubdate;
    NSMutableString *link;
    NSMutableString *images;
    NSMutableString *content;
    NSString *element;
    NSMutableDictionary *item;

}
@property (weak, nonatomic) IBOutlet UITableView *table_view;

@end
