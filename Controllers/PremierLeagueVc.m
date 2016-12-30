//
//  PremierLeagueVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "PremierLeagueVc.h"
#import "PremierLeagueCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "clubDetailVc.h"
#import "ContextMenuCell.h"
#import "YALContextMenuTableView.h"
#import "ExampleViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "CompetitionsVc.h"

static NSString *const menuCellIdentifier = @"rotationCell";

@interface PremierLeagueVc ()
<
UITableViewDelegate,
UITableViewDataSource,
YALContextMenuTableViewDelegate
>

{
    NSArray *imageArray;
}
@property (nonatomic, strong) YALContextMenuTableView* contextMenuTableView;
@property (nonatomic, strong) NSArray *menuTitles;
@property (nonatomic, strong) NSArray *menuIcons;

@end

@implementation PremierLeagueVc
@synthesize teamCollectionView, Exvc, FixVc;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ballRotation)
                                                 name:@"BallRotate"
                                               object:nil];
    
    // Do any additional setup after loading the view.
    NSString *path = [[NSBundle mainBundle]pathForResource:@"crestImages" ofType:@"plist"];
    NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
    if ([_compName isEqualToString:@"Premier League"]) {
        
       imageArray = [dict objectForKey:@"EPL"];
    }
   else if ([_compName isEqualToString:@"Primera Division"]) {
        
        imageArray = [dict objectForKey:@"BBVA"];
    }
   else if ([_compName isEqualToString:@"1.Bundes Liga"]) {
       
       imageArray = [dict objectForKey:@"Bundes"];
   }
   else if ([_compName isEqualToString:@"Ligue 1"]) {
       
       imageArray = [dict objectForKey:@"Ligue1"];
   }
    else
    {
    imageArray = [dict objectForKey:@"EPL"];
    
    }
    
   
    
     [self initiateMenuOptions];

//    imageArray = @[@"Hull_City_AFC.png", @"Leicester02.png", @"FC_Southampton.png", @"Watford.png", @"Middlesbrough_FC_crest.png", @"Stoke_City.png", @"Everton_FC.png", @"Tottenham_Hotspur.png", @"Crystal_Palace_F.C._logo_(2013).png", @"West_Bromwich_Albion.png", @"Burnley_FC_badge.png", @"Swansea_City_Logo.png", @"Manchester_City_FC_badge.png", @"AFC_Sunderland.png", @"Afc_bournemouth.png", @"Manchester_United_FC.png", @"Arsenal_FC.png", @"FC_Liverpool.png", @"Chelsea_crest.png", @"West_Ham_United_FC.png"];
    [self webServiceHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)webServiceHandler {
    
      NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.football-data.org/v1/competitions/%@/teams",_compNo]]];

        [myRequest setValue:@"296672553f954624af8893f4aa95b68c" forHTTPHeaderField:@"X-Auth-Token"];
        [myRequest setHTTPMethod:@"GET"];

    //[myRequest setValue:@"application/json;charset=UTF-8" forHTTPHeaderField:@"Content-Length"];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    

    
    [[session dataTaskWithRequest:myRequest
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
             dispatch_async(dispatch_get_main_queue(), ^{
                    if (data!=Nil) {
                        
                        NSLog(@"error is %@", error);
                        NSError *error;
                        jsonObj = [NSJSONSerialization
                                              JSONObjectWithData:data
                                              options:kNilOptions
                                              error:&error];
                        
                        teamsDict = [jsonObj objectForKey:@"teams"];
                        playerDict = [teamsDict valueForKey:@"_links"];
                        playerArray = [playerDict valueForKey:@"players"];
                        playerHref = [playerArray valueForKey:@"href"];
                        nameArray = [teamsDict valueForKey:@"name"];
                        codeArray = [teamsDict valueForKey:@"code"];
                        valueArray = [teamsDict valueForKey:@"squadMarketValue"];
                        crestUrlArray = [teamsDict valueForKey:@"crestUrl"];
                        
                        [teamCollectionView reloadData];
                        NSLog(@"response data-->%@",jsonObj);
                        
                    }
             });
                    
                }] resume];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based ap
 plication, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return nameArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    
    PremierLeagueCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    // Ball animation
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 2.0;
    rotation.repeatCount = HUGE_VALF;
    [cell.BtnBall.layer addAnimation:rotation forKey:@"Spin"];
    
    cell.clubNameLbl.text = [nameArray objectAtIndex:indexPath.row];
    NSString *str = [codeArray objectAtIndex:indexPath.row];
    NSLog(@"%@",str);

    if ([str isEqual:[NSNull null]]) {
        cell.shortNameLbl.text = @"N/A";
    }
    else
    {
    cell.shortNameLbl.text = [codeArray objectAtIndex:indexPath.row];
    }
    
    if ([str isEqual:[NSNull null]]) {
        cell.marketValueLbl.text = @"N/A";
    }
    else{
    cell.marketValueLbl.text = [valueArray objectAtIndex:indexPath.row];
    }

    
  //  [cell.logoImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]
  //                     placeholderImage:[UIImage imageNamed:@""]];
    
    cell.logoImageView.image = [UIImage imageNamed:[imageArray objectAtIndex:indexPath.row]];

  
    cell.layer.masksToBounds = NO;
    cell.layer.borderColor = (__bridge CGColorRef _Nullable)([UIColor clearColor]);
  //  cell.layer.borderWidth = 30.0f;
    cell.layer.contentsScale = [UIScreen mainScreen].scale;
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 3.0f;
    cell.layer.shadowOffset = CGSizeZero;
    cell.layer.shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds].CGPath;
    cell.layer.shouldRasterize = YES;
    cell.layer.cornerRadius = 5.0f;
    return cell;
}

-(void)ballRotation
{
    [teamCollectionView reloadData];

}
- (IBAction)CancelBtn:(id)sender {
    
    

    [self dismissViewControllerAnimated:YES completion:^{
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"BallRotate"
                                                            object:nil
                                                          userInfo:nil];

    }];
    }



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

//     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    clubDetailVc *vc = [storyboard instantiateViewControllerWithIdentifier:@"clubDetailVc"];
//   // clubDetailVc *viewController=[[clubDetailVc alloc] initWithNibName:@"clubDetailVc" bundle:nil];
//    vc.club_name = [nameArray objectAtIndex:indexPath.row];
//    vc.playerURL = [playerHref objectAtIndex:indexPath.row];
//    [self presentViewController:vc animated:YES completion:nil];

}

#pragma mark YALContextMenu

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    //should be called after rotation animation completed
    [self.contextMenuTableView reloadData];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    [self.contextMenuTableView updateAlongsideRotation];
}

- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    
    [coordinator animateAlongsideTransition:nil completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //should be called after rotation animation completed
        [self.contextMenuTableView reloadData];
    }];
    [self.contextMenuTableView updateAlongsideRotation];
    
}

#pragma mark - IBAction

- (IBAction)moreBtnPressed:(id)sender {
    
    CGPoint buttonPosition = [sender convertPoint:CGPointZero
                                           toView:self.teamCollectionView];
    tappedIP = [self.teamCollectionView indexPathForItemAtPoint:buttonPosition];
   
    if (!self.contextMenuTableView) {
        self.contextMenuTableView = [[YALContextMenuTableView alloc]initWithTableViewDelegateDataSource:self];
        self.contextMenuTableView.animationDuration = 0.15;
        //optional - implement custom YALContextMenuTableView custom protocol
        self.contextMenuTableView.yalDelegate = self;
        //optional - implement menu items layout
        self.contextMenuTableView.menuItemsSide = Right;
        self.contextMenuTableView.menuItemsAppearanceDirection = FromBottomToTop;
        
        //register nib
        UINib *cellNib = [UINib nibWithNibName:@"ContextMenuCell" bundle:nil];
        [self.contextMenuTableView registerNib:cellNib forCellReuseIdentifier:menuCellIdentifier];
    }
    
    // it is better to use this method only for proper animation
    [self.contextMenuTableView showInView:self.view withEdgeInsets:UIEdgeInsetsZero animated:YES];
    
}
#pragma mark - Local methods

- (void)initiateMenuOptions {
    self.menuTitles = @[@"",
                        @"PLAYERS",
                        @"FIXTURES",
                        @"TABLE"];
//                        @"Add to favourites",
//                        @"Block user"];
    
    self.menuIcons = @[[UIImage imageNamed:@"Icnclose"],
                       [UIImage imageNamed:@"Players"],
                       [UIImage imageNamed:@"Fixtures"],
                       [UIImage imageNamed:@"Table"]];
//                       [UIImage imageNamed:@"AddToFavouritesIcn"],
//                       [UIImage imageNamed:@"BlockUserIcn"]];
}


#pragma mark - YALContextMenuTableViewDelegate

- (void)contextMenuTableView:(YALContextMenuTableView *)contextMenuTableView didDismissWithIndexPath:(NSIndexPath *)indexPath{

    teamCollectionView.backgroundColor = [self.teamCollectionView.backgroundColor colorWithAlphaComponent:0];

    if (indexPath.row==0) {
        
           }
    else if(indexPath.row==1)
    {
    NSLog(@"Menu dismissed with indexpath = %@", indexPath);
    Exvc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ExampleViewController"];
        [self playerURL];
  //  vc.playerUrlStr = [playerHref objectAtIndex:indexPath.row];
    [self presentViewController:Exvc animated:YES completion:nil];
    }
    else if(indexPath.row==2)
    {
    
        FixVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"FixtureVc"];
        [self presentViewController:FixVc animated:YES completion:nil];
        
    
    
    }
}

-(void)playerURL
{
Exvc.playerUrlStr = [playerHref objectAtIndex:(long)tappedIP.row];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate

- (void)tableView:(YALContextMenuTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView dismisWithIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.menuTitles.count;
}

- (UITableViewCell *)tableView:(YALContextMenuTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ContextMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifier forIndexPath:indexPath];
    
    if (cell) {
        cell.backgroundColor = [UIColor clearColor];
        cell.menuTitleLabel.text = [self.menuTitles objectAtIndex:indexPath.row];
        cell.menuImageView.image = [self.menuIcons objectAtIndex:indexPath.row];
    }
    
    return cell;
}
@end
