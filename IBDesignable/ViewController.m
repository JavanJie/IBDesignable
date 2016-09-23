//
//  ViewController.m
//  IBDesignable
//
//  Created by 陈杰 on 16/9/7.
//  Copyright © 2016年 陈杰. All rights reserved.
//

#import "ViewController.h"
#import "RoundableButton.h"
#import "IBDesignableImageView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet IBDesignableImageView *blurImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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
