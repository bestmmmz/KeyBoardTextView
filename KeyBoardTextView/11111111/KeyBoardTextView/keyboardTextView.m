//
//  keyboardTextView.m
//  11111111
//
//  Created by Laomeng on 16/11/20.
//  Copyright © 2016年 Laomeng. All rights reserved.
//

#import "keyboardTextView.h"
#import "GrowingTextView.h"
#import "Color.h"

@interface keyboardTextView () <GrowingTextViewDelegate>
{
    GrowingTextView *textView;
    CGRect defaultRect;
    CGRect keyboardBounds;
    CGFloat textViewDefaultHeight;
    NSLayoutConstraint *bgViewBottomC;
    NSLayoutConstraint *bgViewHeightC;
}
@property (nonatomic, strong) UIView *coverView;
@property (nonatomic, strong) UIView *textViewBgView;
@property (nonatomic, strong) UIButton *sendBtn;
@end

@implementation keyboardTextView

- (instancetype)initWithTextViewFrame:(CGRect)frame
{
    if (self = [super init]) {
        defaultRect = frame;
        self.frame = [UIScreen mainScreen].bounds;
        [self setup];
        [self addKeyBoardNotification];
    }
    return self;
}

- (void)setup
{
    self.textViewBgView = [UIView new];
    self.textViewBgView.translatesAutoresizingMaskIntoConstraints = NO;
    self.textViewBgView.backgroundColor = [Color colorWithHex:@"#EFEFEF"];
    [self addSubview:self.textViewBgView];
    NSLayoutConstraint *bgViewLeftC = [NSLayoutConstraint constraintWithItem:self.textViewBgView
                                                                    attribute:NSLayoutAttributeLeft
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:self
                                                                    attribute:NSLayoutAttributeLeft
                                                                   multiplier:1.f
                                                                     constant:0.f];
    bgViewBottomC = [NSLayoutConstraint constraintWithItem:self.textViewBgView
                                                 attribute:NSLayoutAttributeBottom
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                 attribute:NSLayoutAttributeBottom
                                                multiplier:1.f
                                                  constant:0.f];
    NSLayoutConstraint *bgViewWidthC = [NSLayoutConstraint constraintWithItem:self.textViewBgView
                                                                    attribute:NSLayoutAttributeWidth
                                                                    relatedBy:NSLayoutRelationEqual
                                                                       toItem:nil
                                                                    attribute:NSLayoutAttributeNotAnAttribute
                                                                   multiplier:1.f
                                                                     constant:[UIScreen mainScreen].bounds.size.width];
    bgViewHeightC = [NSLayoutConstraint constraintWithItem:self.textViewBgView
                                                 attribute:NSLayoutAttributeHeight
                                                 relatedBy:NSLayoutRelationEqual
                                                    toItem:nil
                                                 attribute:NSLayoutAttributeNotAnAttribute
                                                multiplier:1.f
                                                  constant:defaultRect.size.height];
    [self addConstraints:@[bgViewLeftC, bgViewBottomC]];
    [self.textViewBgView addConstraints:@[bgViewWidthC, bgViewHeightC]];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.sendBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.sendBtn.enabled = NO;
    self.sendBtn.adjustsImageWhenDisabled = NO;
    [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"button_send_noshuru"] forState:UIControlStateNormal];
    [self.sendBtn addTarget:self action:@selector(sendMesAcition:) forControlEvents:UIControlEventTouchUpInside];
    [self.textViewBgView addSubview:self.sendBtn];
    NSLayoutConstraint *sendBtnRightC = [NSLayoutConstraint constraintWithItem:self.sendBtn
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.textViewBgView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.f
                                                               constant:-14.f];
    NSLayoutConstraint *sendBtnBottomC = [NSLayoutConstraint constraintWithItem:self.sendBtn
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.textViewBgView
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.f
                                                                constant:-7.f];
    NSLayoutConstraint *sendBtnWidthC = [NSLayoutConstraint constraintWithItem:self.sendBtn
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeNotAnAttribute
                                                             multiplier:1.f
                                                               constant:47.f];
    NSLayoutConstraint *sendBtnHeightC = [NSLayoutConstraint constraintWithItem:self.sendBtn
                                                               attribute:NSLayoutAttributeHeight
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:nil
                                                               attribute:NSLayoutAttributeNotAnAttribute
                                                              multiplier:1.f
                                                                constant:35];
    [self.textViewBgView addConstraints:@[sendBtnRightC, sendBtnBottomC]];
    [self.sendBtn addConstraints:@[sendBtnWidthC, sendBtnHeightC]];
    
    textView = [GrowingTextView new];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.isScrollable = NO;
    textView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    textView.minNumberOfLines = 1;
    textView.maxHeight = 90.f;
    textView.animateHeightChange = NO;
    textView.returnKeyType = UIReturnKeySend;
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.textColor = [Color colorWithHex:@"#2C2C2C"];
    textView.delegate = self;
    textView.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    textView.backgroundColor = [Color colorWithHex:@"#EFEFEF"];
    textView.layer.borderWidth = 1.f;
    textView.layer.borderColor = [Color colorWithHex:@"#2C2C2C"].CGColor;
    textView.layer.cornerRadius = 5.f;
    textView.layer.masksToBounds = YES;
    textView.internalTextView.tintColor = [UIColor blackColor];
    textView.placeholder = @"说点什么吧";
    [self.textViewBgView addSubview:textView];
    NSLayoutConstraint *topC1 = [NSLayoutConstraint constraintWithItem:textView
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.textViewBgView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.f
                                                                      constant:7.5f];
    NSLayoutConstraint *leftC1 = [NSLayoutConstraint constraintWithItem:textView
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.textViewBgView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.f
                                                                       constant:14.f];
    NSLayoutConstraint *bottomC1 = [NSLayoutConstraint constraintWithItem:textView
                                                                attribute:NSLayoutAttributeBottom
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.textViewBgView
                                                                attribute:NSLayoutAttributeBottom
                                                               multiplier:1.f
                                                                 constant:-7.5f];
    NSLayoutConstraint *rightC1 = [NSLayoutConstraint constraintWithItem:self.sendBtn
                                                               attribute:NSLayoutAttributeLeft
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:textView
                                                               attribute:NSLayoutAttributeRight
                                                              multiplier:1.f
                                                                constant:7.f];
    [self.textViewBgView addConstraints:@[topC1, leftC1, bottomC1, rightC1]];
    textViewDefaultHeight = textView.frame.size.height;

    self.coverView = [UIView new];
    self.coverView.backgroundColor = [UIColor blackColor];
    self.coverView.alpha = .5f;
    self.coverView.translatesAutoresizingMaskIntoConstraints = NO;
    self.coverView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverViewClick)];
    [self.coverView addGestureRecognizer:tapG];
    self.coverView.hidden = YES;
    [self addSubview:self.coverView];
    NSLayoutConstraint *coverHeight = [NSLayoutConstraint constraintWithItem:self.coverView
                                                                attribute:NSLayoutAttributeHeight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:nil
                                                                attribute:NSLayoutAttributeNotAnAttribute
                                                               multiplier:1.f
                                                                 constant:1000.f];
    NSLayoutConstraint *coverLeft = [NSLayoutConstraint constraintWithItem:self.coverView
                                                                attribute:NSLayoutAttributeLeft
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.textViewBgView
                                                                attribute:NSLayoutAttributeLeft
                                                               multiplier:1.f
                                                                 constant:0];
    NSLayoutConstraint *coverRight = [NSLayoutConstraint constraintWithItem:self.coverView
                                                                attribute:NSLayoutAttributeRight
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:self.textViewBgView
                                                                attribute:NSLayoutAttributeRight
                                                               multiplier:1.f
                                                                 constant:0];
    NSLayoutConstraint *coverrBottom = [NSLayoutConstraint constraintWithItem:self.textViewBgView
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:self.coverView
                                                                  attribute:NSLayoutAttributeBottom
                                                                 multiplier:1.f
                                                                   constant:0];
    [self addConstraints:@[coverHeight, coverLeft, coverRight, coverrBottom]];
}

- (void)addKeyBoardNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification 
                                               object:nil];	
}

-(void)keyboardWillShow:(NSNotification *)note{
    [[note.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    
    bgViewBottomC.constant = -keyboardBounds.size.height;
    [UIView animateWithDuration:duration.floatValue animations:^{
        [self layoutIfNeeded];
        self.coverView.hidden = NO;
    }];
}

-(void)keyboardWillHide:(NSNotification *)note{
    NSNumber *duration = [note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    bgViewBottomC.constant = 0.f;
    [UIView animateWithDuration:duration.floatValue animations:^{
        [self layoutIfNeeded];
        self.coverView.hidden = YES;
    }];
}

- (void)growingTextView:(GrowingTextView *)growingTextView willChangeHeight:(float)height
{
    bgViewHeightC.constant = height + 15.f;
    [self layoutIfNeeded];
}

- (BOOL)growingTextView:(GrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ((growingTextView.internalTextView.text.length > 1 && text.length == 0) ||( text.length != 0)) {
        [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"button_send"] forState:UIControlStateNormal];
        self.sendBtn.enabled = YES;
    }else {
        [self.sendBtn setBackgroundImage:[UIImage imageNamed:@"button_send_noshuru"] forState:UIControlStateNormal];
        self.sendBtn.enabled = NO;
    }
    return YES;
}

- (BOOL)growingTextViewShouldReturn:(GrowingTextView *)growingTextView
{
    if (textView.text.length > 0) {
        self.SendMesButtonClickedBlock(textView.text);
        textView.text = @"";
    }
    if (textView.internalTextView.isFirstResponder) {
        [textView.internalTextView endEditing:YES];
    }
    return YES;
}

- (void)coverViewClick
{
    if (textView.internalTextView.isFirstResponder) {
        [textView.internalTextView endEditing:YES];
    }
}

- (void)sendMesAcition:(UIButton *)sender
{
    if (textView.text.length > 0) {
        self.SendMesButtonClickedBlock(textView.text);
        textView.text = @"";
    }
    if (textView.internalTextView.isFirstResponder) {
        [textView.internalTextView endEditing:YES];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
