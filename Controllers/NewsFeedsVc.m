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
{
    UIView *detailView;
    UIWebView *web;
    UIActivityIndicatorView *spinner;
    NSMutableArray *linkArray;
}
@end

@implementation NewsFeedsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor whiteColor];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.table_view addSubview:refreshControl];
    [self.table_view setSeparatorColor:[UIColor whiteColor]];

    mutLinkArray = [[NSMutableArray alloc]init];
    [self.navigationController setNavigationBarHidden:NO];
    [self webservice];
    NSLog(@"feed-->%@",feeds);
    NSLog(@"%@",mutLinkArray);
    
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
    
//    self.navigationItem.hidesBackButton=YES;
//    detailView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
//    [self.view addSubview:detailView];
//    [detailView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1]];
//    
//    web = [[UIWebView alloc]initWithFrame:CGRectMake(10, 10, detailView.bounds.size.width-20, detailView.bounds.size.height-20)];
//    [web setDelegate:self];
//    NSString *htmlURL = [link stringByReplacingOccurrencesOfString:@"\n\t\t" withString:@""];
//    spinner = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    spinner.frame = CGRectMake(166, 300, 10, 10);
//    [web addSubview:spinner];
//    
////     dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
////         
////         
////     });
//    dispatch_async(dispatch_get_main_queue(), ^{
//         [spinner startAnimating];
//    [web loadRequest:[NSURLRequest requestWithURL:mutLinkArray[indexPath.row]]];
//    [detailView addSubview:web];
//       
//    });
//    
//    imgV = [[UIImageView alloc]initWithFrame:CGRectMake(315, 2, 30, 30)];
//    imgV.image = [UIImage imageNamed:@"close1.png"];
//    [web addSubview:imgV];
//    
//    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
//    tapGestureRecognizer.numberOfTapsRequired = 1;
//    [imgV setUserInteractionEnabled:YES];
//    [tapGestureRecognizer setDelegate:self];
//    [imgV addGestureRecognizer:tapGestureRecognizer];
//    
//    CATransition *animation = [CATransition animation];
//    [animation setType:kCATransitionPush];
//    [animation setSubtype:kCATransitionFromBottom];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//    [animation setDelegate:self];
//    [animation setDuration:2];
//    [detailView.layer addAnimation:animation forKey:@""];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    

}
-(void)viewDidAppear:(BOOL)animated
{
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [spinner stopAnimating];

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
        link           = [[NSMutableString alloc]init];
        
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
    if ([element isEqualToString:@"link"]) {
        [link appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:description forKey:@"title"];
        [item setObject:thumbnail forKey:@"thumbnail"];
        [item setObject:pubdate forKey:@"pubDate"];
        [item setObject:images forKey:@"image"];
        [item setObject:content forKey:@"content"];
        
        for (int i=0; i<10; i++) {
  
        [mutLinkArray insertObject:link atIndex:i];
        }
        
        [feeds addObject:[item copy]];
        
    }
    
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.table_view reloadData];
    
}

-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    [detailView removeFromSuperview];
    self.navigationItem.hidesBackButton=NO;
    
}
@end
