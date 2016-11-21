//
//  testVC.m
//  11111111
//
//  Created by Laomeng on 16/11/20.
//  Copyright © 2016年 Laomeng. All rights reserved.
//

#import "testVC.h"
#import "keyboardTextView.h"

@interface testVC ()
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation testVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    keyboardTextView *kTextView = [[keyboardTextView alloc] initWithTextViewFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 49, [UIScreen mainScreen].bounds.size.width, 49)];
    [kTextView setSendMesButtonClickedBlock:^(NSString *text) {
        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"Tip"
                                                         message:text
                                                        delegate:nil
                                               cancelButtonTitle:nil
                                               otherButtonTitles:@"OK", nil];
        [alertV show];
    }];
    [self.view addSubview:kTextView];
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

@end
