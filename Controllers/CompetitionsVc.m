//
//  CompetitionsVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 23/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "CompetitionsVc.h"

@interface CompetitionsVc ()

@end

@implementation CompetitionsVc
@synthesize jsonObj;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webServiceHandler {
    
    NSMutableURLRequest *myRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://api.football-data.org/v1/competitions/?season=2016"]];
    
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
                            responseArray = [NSJSONSerialization
                                       JSONObjectWithData:data
                                       options:kNilOptions
                                       error:&error];
                            idArray = [responseArray valueForKey:@"id"];
                            leagueArray = [responseArray valueForKey:@"caption"];
                            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                            for (int i=0;i<idArray.count ; i++) {
                    
                            [dict setValue:idArray[i] forKey:[NSString stringWithFormat:@"%@",leagueArray[i]]];
                            }
                            [[NSUserDefaults standardUserDefaults]setObject:dict forKey:@"CompetitionID"];
                            
                            NSLog(@"response data-->%@",dict);
                            
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
