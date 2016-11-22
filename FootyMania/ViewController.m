//
//  ViewController.m
//  TrackFooty
//
//  Created by BICS-Mac Mini-1 on 04/11/16.
//  Copyright © 2016 BICS. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "PopMenu.h"
#import "ShowMenuVc.h"
#import "PremierLeagueVc.h"
#import "RssTableCell.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;

@property (nonatomic, strong) PopMenu *popMenu;

@end

@implementation ViewController
@synthesize backgroundimgView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ballRotation)
                                                 name:@"BallRotate"
                                               object:nil];
    [self ballRotation];
    

    [self.navigationController setNavigationBarHidden:YES];
    backgroundimgView.image = [UIImage imageNamed:@"55.jpg"];
    imgArray = @[@"22.jpg",@"33.jpg",@"44.jpg",@"55.jpg",@"66.jpg",@"77.jpg",@"11.jpg"];
  //  mytimer = [NSTimer scheduledTimerWithTimeInterval:10.00 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
   
    
}
-(void)ballRotation
{
    CABasicAnimation *rotation;
    rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithFloat:0];
    rotation.toValue = [NSNumber numberWithFloat:(2*M_PI)];
    rotation.duration = 2.0;
    rotation.repeatCount = HUGE_VALF;
    [_ballBtnRotate.layer addAnimation:rotation forKey:@"Spin"];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//   ShowMenuVc *vc = [[ShowMenuVc alloc]init];
//   [vc showMenu];
//    
//    if (!_popMenu) {
//        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:vc.items];
//        _popMenu.menuAnimationType = kPopMenuAnimationTypeNetEase;
//    }
//    if (_popMenu.isShowed) {
//        return;
//    }
//    __weak typeof(self) weakSelf = self;
//    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
//        NSLog(@"%@",selectedItem.title);
//        
//        PremierLeagueVc *PLVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PremierLeagueVc"];
//        
//        [weakSelf presentViewController:PLVc animated:YES completion:nil];
//       
//
//    };
//     [_popMenu showMenuAtView:self.view];
 //    [self showMenu];
}

- (void)changeImage
{
    static int counter = 0;
    int i=1;
    if(([imgArray count]+i) == counter+1)
    {
        counter = 0;
    }
    backgroundimgView.image = [UIImage imageNamed:[imgArray objectAtIndex:counter]];
    CATransition *transition = [CATransition animation];
    transition.duration = 1.00;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionFade;
    transition.delegate = self;
    [self.view.layer addAnimation:transition forKey:nil];
    counter++;
                       }

- (IBAction)ballBtn:(id)sender {
    
    ShowMenuVc *vc = [[ShowMenuVc alloc]init];
    [vc showMenu];
    
    if (!_popMenu) {
        _popMenu = [[PopMenu alloc] initWithFrame:self.view.bounds items:vc.items];
        _popMenu.menuAnimationType = kPopMenuAnimationTypeSina;
    }
    if (_popMenu.isShowed) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    _popMenu.didSelectedItemCompletion = ^(MenuItem *selectedItem) {
        NSLog(@"%@",selectedItem.title);
        
        PremierLeagueVc *PLVc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"PremierLeagueVc"];
        
        [weakSelf presentViewController:PLVc animated:YES completion:nil];
        
        
    };
    [_popMenu showMenuAtView:self.view];
}


@end
