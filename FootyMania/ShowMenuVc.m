//
//  ShowMenuVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "ShowMenuVc.h"
#import "PopMenu.h"

@interface ShowMenuVc ()

@property (nonatomic, strong) PopMenu *popMenu;
@end

@implementation ShowMenuVc
@synthesize items;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu {
    items = [[NSMutableArray alloc] initWithCapacity:3];
    
    MenuItem *menuItem = [MenuItem itemWithTitle:@"Premier League" iconName:@"Premier_league"];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Primera Division" iconName:@"La_liga"]; //glowColor:[UIColor colorWithRed:0.840 green:0.264 blue:0.208 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"1.Bundes Liga" iconName:@"Bundes_liga" ];//glowColor:[UIColor colorWithRed:0.232 green:0.442 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Serie A" iconName:@"Serie_A"]; //glowColor:[UIColor colorWithRed:0.000 green:0.509 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Ligue 1" iconName:@"League_one"]; //glowColor:[UIColor colorWithRed:0.687 green:0.164 blue:0.246 alpha:0.800]];
    [items addObject:menuItem];
    
    menuItem = [MenuItem itemWithTitle:@"Champions League" iconName:@"Champions_league" ];//glowColor:[UIColor colorWithRed:0.258 green:0.245 blue:0.687 alpha:0.800]];
    [items addObject:menuItem];
    
//    if (!_popMenu) {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:items];
//        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
//    }
//    if (_popMenu.isShowed) {
//        return;
//    }
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//        NSLog(@"%@",selectedItem.title);
//    };
    
 //   [_popMenu showMenuAtView:self.view];
    
    //    [_popMenu showMenuAtView:self.view startPoint:CGPointMake(CGRectGetWidth(self.view.bounds) - 60, CGRectGetHeight(self.view.bounds)) endPoint:CGPointMake(60, CGRectGetHeight(self.view.bounds))];
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
