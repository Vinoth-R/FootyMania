//
//  NewsFeedsVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 11/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "NewsFeedsVc.h"
#import "RssTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NewsDetailVc.h"

@interface NewsFeedsVc ()

@end

@implementation NewsFeedsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.table_view addSubview:refreshControl];
    [self.table_view setSeparatorColor:[UIColor whiteColor]];

    [self.navigationController setNavigationBarHidden:NO];
    [self webservice];
    NSLog(@"feed-->%@",feeds);
    
}

- (void)refresh:(UIRefreshControl *)refreshControl {
    
    [self webservice];
    [self.table_view reloadData];
    [refreshControl endRefreshing];
}

-(void)viewWillDisappear:(BOOL)animated
{

[self.navigationController setNavigationBarHidden:YES];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BallRotate"
                                                        object:nil
                                                      userInfo:nil];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)webservice
{
    feeds = [[NSMutableArray alloc] init];
    NSURL *feedurl = [NSURL URLWithString:@"http://www.footballfancast.com/feed"];
    parser = [[NSXMLParser alloc]initWithContentsOfURL:feedurl];
    [parser setDelegate:self];
    [parser setShouldResolveExternalEntities:NO];
    [parser parse];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return feeds.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RssTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.newsLbl.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"title"];
    cell.pubDateLbl.text = [[feeds objectAtIndex:indexPath.row] objectForKey: @"pubDate"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[[feeds objectAtIndex:indexPath.row]objectForKey:@"thumbnail"]]
                 placeholderImage:[UIImage imageNamed:@"Ball.png"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
         NewsDetailVc *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"NewsDetailVc"];
    vc.newsStr = [[feeds objectAtIndex:indexPath.row]objectForKey:@"content"];
    vc.imgStr = [[feeds objectAtIndex:indexPath.row]objectForKey:@"image"];
    [self.navigationController pushViewController:vc animated:YES];
    

}



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item           = [[NSMutableDictionary alloc]init];
        description    = [[NSMutableString alloc] init];
        thumbnail      = [[NSMutableString alloc] init];
        pubdate        = [[NSMutableString alloc] init];
        images         = [[NSMutableString alloc]init];
        content         = [[NSMutableString alloc]init];

        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [description appendString:string];
    }
    
    if ([element isEqualToString:@"thumbnail"]) {
        [thumbnail appendString:string];
    }
    if ([element isEqualToString:@"pubDate"]) {
        [pubdate appendString:string];
    }
    if ([element isEqualToString:@"image"]) {
        [images appendString:string];
    }
    if ([element isEqualToString:@"content:encoded"]) {
        [content appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:description forKey:@"title"];
        [item setObject:thumbnail forKey:@"thumbnail"];
        [item setObject:pubdate forKey:@"pubDate"];
        [item setObject:images forKey:@"image"];
        [item setObject:content forKey:@"content"];

        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.table_view reloadData];
    
}

@end
