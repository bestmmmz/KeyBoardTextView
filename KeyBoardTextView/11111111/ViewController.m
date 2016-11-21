//
//  ViewController.m
//  11111111
//
//  Created by Laomeng on 16/11/19.
//  Copyright © 2016年 Laomeng. All rights reserved.
//

#import "ViewController.h"
#import "testVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn1 = [UIButton buttonWithType: UIButtonTypeCustom];
    btn1.frame = CGRectMake(20, 300, 350, 100);
    [btn1 setTitle:@"测试KeyBoardTextView" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:30];
    [btn1 addTarget:self action:@selector(KeyBoardTextView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)KeyBoardTextView
{
    testVC *vc = [testVC new];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
