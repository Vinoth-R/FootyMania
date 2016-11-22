//
//  clubDetailVc.m
//  FootyMania
//
//  Created by BICS-Mac Mini-1 on 08/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "clubDetailVc.h"
#import "ExampleViewController.h"

@interface clubDetailVc ()

@end

@implementation clubDetailVc
@synthesize club_name, title;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _nav.topItem.title = club_name;


 dispatch_async(dispatch_get_main_queue(), ^{
 });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backBtn:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)playerBtn:(id)sender {
    
    ExampleViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"ExampleViewController"];
    vc.playerUrlStr = _playerURL;
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
