//
//  TransferNewsVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 30/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "TransferNewsVc.h"
#import "TransferTableCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface TransferNewsVc ()
{
    UIView *detailView;
    NSMutableArray *mutArray;
    UIWebView *web;
}
@end

@implementation TransferNewsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    [self webservice];
    NSLog(@"description-->%@",description);
    [self.navigationController setNavigationBarHidden:NO];
     mutArray = [[NSMutableArray alloc]init];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapReceived:)];
    [tapGestureRecognizer setDelegate:self];
    [web addGestureRecognizer:tapGestureRecognizer];
    // Do any additional setup after loading the view.
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return feeds.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TransferTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSString *htmlStr = [[feeds objectAtIndex:indexPath.row]objectForKey:@"description"];
  //  NSString *alteredHtmlStr = [htmlStr stringByReplacingOccurrencesOfString:@"html'>" withString:@"html style=\"display: inline-block; float: left;\">"];

    //image url
    NSRange startUrl = [htmlStr rangeOfString:@"src"];
    NSRange endUrl = [[htmlStr substringFromIndex:startUrl.location] rangeOfString:@"'>"];
    NSString *urlStr = [htmlStr substringWithRange:NSMakeRange(startUrl.location, endUrl.location)];
    NSString *trimmedHtmlStr = [urlStr stringByReplacingOccurrencesOfString:@"src='" withString:@""];
    
    //story description
    NSRange startDes = [htmlStr rangeOfString:@"<BR>"];
    NSRange endDes = [[htmlStr substringFromIndex:startDes.location] rangeOfString:@"</p>"];
    NSString *urlDes = [htmlStr substringWithRange:NSMakeRange(startDes.location, endDes.location)];
    NSString *trimmedStr = [urlDes stringByReplacingOccurrencesOfString:@"<BR>" withString:@""];
    
    //html url
    NSRange startHtmlUrl = [htmlStr rangeOfString:@"HREF='"];
    NSRange endHtmlUrl = [[htmlStr substringFromIndex:startHtmlUrl.location] rangeOfString:@"'>"];
    NSString *htmlUrl = [htmlStr substringWithRange:NSMakeRange(startHtmlUrl.location, endHtmlUrl.location)];
    trimmedJUrlStr = [htmlUrl stringByReplacingOccurrencesOfString:@"HREF='" withString:@""];
    [mutArray addObject:trimmedJUrlStr];
    
    cell.label.text = trimmedStr;
    
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:trimmedHtmlStr] placeholderImage:[UIImage imageNamed:@"Ball.png"]];
            return cell ;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    detailView = [[UIView alloc]initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height)];
    [self.view addSubview:detailView];
    [detailView setBackgroundColor:[UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:0.5f]];
    
    web = [[UIWebView alloc]initWithFrame:CGRectMake(10, 10, detailView.bounds.size.width-20, detailView.bounds.size.height-20)];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:mutArray[indexPath.row]]]];
    [detailView addSubview:web];
    
    CATransition *animation = [CATransition animation];
    
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionReveal];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
    [animation setDelegate:self];
    [animation setDuration:2];
    [detailView.layer addAnimation:animation forKey:@"animate"];

}
- (void)animateViewHeight:(UIView*)animateView withAnimationType:(NSString*)animType {
    CATransition *animation = [CATransition animation];
    [animation setType:kCATransitionPush];
    [animation setSubtype:animType];
    
    [animation setDuration:0.5];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [[animateView layer] addAnimation:animation forKey:kCATransition];
    animateView.hidden = !animateView.hidden;
}

-(void)webservice
{
    feeds = [[NSMutableArray alloc] init];
    NSURL *feedurl = [NSURL URLWithString:@"http://www.eyefootball.com/rss_news_transfers.xml"];
    parser = [[NSXMLParser alloc]initWithContentsOfURL:feedurl];
    [parser setDelegate:self];
   [parser setShouldResolveExternalEntities:NO];
     [parser parse];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    element = elementName;
    
    if ([element isEqualToString:@"item"]) {
        
        item           = [[NSMutableDictionary alloc]init];
        description    = [[NSMutableString alloc] init];
        thumbnail      = [[NSMutableString alloc] init];
        pubdate        = [[NSMutableString alloc] init];
        images         = [[NSMutableString alloc]init];
        content        = [[NSMutableString alloc]init];
        title          = [[NSMutableString alloc]init];
        
        
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if ([element isEqualToString:@"title"]) {
        [title appendString:string];
    }
    
    if ([element isEqualToString:@"thumbnail"]) {
        [thumbnail appendString:string];
    }
    if ([element isEqualToString:@"pubDate"]) {
        [pubdate appendString:string];
    }
    if ([element isEqualToString:@"description"]) {
        [description appendString:string];
    }
    if ([element isEqualToString:@"content:encoded"]) {
        [content appendString:string];
    }
    
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ([elementName isEqualToString:@"item"]) {
        
        [item setObject:title forKey:@"title"];
        [item setObject:thumbnail forKey:@"thumbnail"];
        [item setObject:pubdate forKey:@"pubDate"];
        [item setObject:description forKey:@"description"];
        [item setObject:content forKey:@"content"];
        
        [feeds addObject:[item copy]];
        
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    [self.table_view reloadData];
    
}
-(void)tapReceived:(UITapGestureRecognizer *)tapGestureRecognizer
{
    NSLog(@"tapped");
}
@end
