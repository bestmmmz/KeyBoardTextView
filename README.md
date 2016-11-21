# KeyBoardTextView
类似微信朋友圈和内涵段子评论回复TextView自动变化高度, 使用简单

使用方法:

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
    
![image](https://github.com/bestmmmz/KeyBoardTextView/blob/master/KeyBoardTextView/11111111/keyboardTextView.gif)
