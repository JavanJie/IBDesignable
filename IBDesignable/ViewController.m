//
//  ViewController.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "ViewController.h"
#import "RoundableButton.h"
#import "IBDImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet IBDImageView *blurImageView;
@property (weak, nonatomic) IBOutlet UISlider *blurSliderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    IBDImageView *blurImageView1 = [[IBDImageView alloc]initWithImage:[UIImage imageNamed:@"cheetah1136"]];
    blurImageView1.frame = CGRectMake(50, 50, 100, 140);
    blurImageView1.blurRadius = 20;
    [self.view addSubview:blurImageView1];
    
    IBDImageView *blurImageView2 = [[IBDImageView alloc]initWithImage:[UIImage imageNamed:@"cheetah1136"] highlightedImage:[UIImage imageNamed:@"cheetah1136"]];
    blurImageView2.frame = CGRectMake(150, 150, 100, 140);
    blurImageView2.blurRadius = 30;
    [self.view addSubview:blurImageView2];
    
    self.blurImageView.blurRadius = self.blurSliderView.value;
}

- (IBAction)buttonTouched:(RoundableButton *)sender {
    NSLog(@"sender borderColor = %@", [sender borderColor]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)blurRadiusChanged:(UISlider *)slider {
    self.blurImageView.blurRadius = slider.value;
}

@end
