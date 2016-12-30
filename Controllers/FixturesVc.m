//
//  FixturesVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 27/12/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "FixturesVc.h"
#import "FixturesCell.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface FixturesVc ()

@end

@implementation FixturesVc
@synthesize jsonObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     AwayMutArray = [[NSMutableArray alloc]init];
    [self webServiceHandler];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MatchDay.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FixturesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.teamTwoLbl.text = [AwayTeamArray objectAtIndex:indexPath.row];
    cell.ScoreLbl.text = [NSString stringWithFormat:@"%@ : %@",[HomeScore objectAtIndex:indexPath.row],[AwayScore objectAtIndex:indexPath.row]];
    cell.imageView1.image = [UIImage imageNamed:@"Chelsea_crest.png"];
    cell.teamOneLbl.text = @"Chelsea FC";
    if (![[HomeTeamArray objectAtIndex:indexPath.row] isEqual: @"Chelsea FC"]) {
        [AwayMutArray insertObject:[HomeTeamArray objectAtIndex:indexPath.row] atIndex:indexPath.row];
    }
    else
    {
    [AwayMutArray insertObject:[AwayTeamArray objectAtIndex:indexPath.row] atIndex:indexPath.row];
   
    }
    cell.teamTwoLbl.text = [AwayMutArray objectAtIndex:indexPath.row];
    //   if(indexPath.row>18)
//   {
//    NSLog(@"%ld",(long)indexPath.row);
//   }
//  else
//  {
//      NSString *home = [HomeTeamArray objectAtIndex:indexPath.row];
//      home = [home stringByReplacingOccurrencesOfString:@" FC" withString:@""];
//      NSString *away = [AwayTeamArray objectAtIndex:indexPath.row];
//      
//      NSString *path = [[NSBundle mainBundle]pathForResource:@"crestImages" ofType:@"plist"];
//      NSDictionary *dict = [[NSDictionary alloc]initWithContentsOfFile:path];
//      NSArray *imageArray = [dict objectForKey:@"EPL"];
//      NSString *imgStr = [imageArray objectAtIndex:indexPath.row];
//      NSString *PngimgStr = [imgStr stringByReplacingOccurrencesOfString:@".png" withString:@""];
//
//
//  if ([PngimgStr containsString:home]) {
//      cell.imageView1.image = [UIImage imageNamed:imgStr];
//     
//  }
    
//    }
    return cell;
}

- (void)webServiceHandler {
    
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://api.football-data.org/v1/teams/61/fixtures"]]];
    
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
                            
                            fixturesArray = [jsonObj objectForKey:@"fixtures"];
                            HomeTeamArray = [fixturesArray valueForKey:@"homeTeamName"];
                            AwayTeamArray = [fixturesArray valueForKey:@"awayTeamName"];
                            MatchDay = [fixturesArray valueForKey:@"matchday"];
                            status = [fixturesArray valueForKey:@"status"];
                            results = [fixturesArray valueForKey:@"result"];
                            HomeScore = [results valueForKey:@"goalsHomeTeam"];
                            AwayScore = [results valueForKey:@"goalsAwayTeam"];
                        
                            NSLog(@"%@,%@,%@,%@",HomeTeamArray,AwayTeamArray,MatchDay,results);
                            [_fixturesTable reloadData];
                            
                        }
                    });
                    
                }] resume];
    
    
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
