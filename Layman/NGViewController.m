//
//  NGViewController.m
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGViewController.h"
#import "NGLayoutSet.h"

@interface NGViewController ()
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *goButton;
@property (nonatomic, strong) NGLayoutSet *layouts;
@end

@implementation NGViewController

@synthesize usernameField = _usernameField, passwordField = _passwordField, goButton = _goButton;
NGDynamic(layouts, NGLayoutSet);

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self usernameField];
    [self passwordField];
    [self goButton];
    [self.layouts applyToView:self.view];
    
    NSLog(@"%@",self.view.constraints);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGRect)defaultFrame
{
    CGRect defaultFrame = CGRectZero;
    defaultFrame.size = CGSizeMake(self.view.frame.size.width, 20.f);
    return defaultFrame;
}

- (UITextField *)usernameField
{
    if (!_usernameField)
    {
        _usernameField = [UITextField.alloc initWithFrame:self.defaultFrame];
        _usernameField.backgroundColor = UIColor.blueColor;
        _usernameField.delegate = self;
        _usernameField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_usernameField];
        
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, CENTER_X, LESS_OR, 0.f)];
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, TOP, LESS_OR, 12.f)];
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, WIDTH, EQUAL, -20.f)];
        [self.layouts applyToView:_usernameField.superview];
    }
    
    return _usernameField;
}

- (UITextField *)passwordField
{
    if (!_passwordField)
    {
        _passwordField = [UITextField.alloc initWithFrame:self.defaultFrame];
        _passwordField.backgroundColor = UIColor.redColor;
        _passwordField.delegate = self;
        _passwordField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_passwordField];
        
        [self.layouts addLayout:NGLayoutEqual(_passwordField, self.usernameField, HEIGHT)];
        [self.layouts addLayout:NGLayoutInSuperview(_passwordField, CENTER_X, LESS_OR, 0.f)];
        [self.layouts addLayout:NGLayoutInSuperview(_passwordField, WIDTH, EQUAL, -20.f)];
        [self.layouts addLayout:NGLayoutFromBottom(_passwordField, self.usernameField, 12.f)];
    }
    
    return _passwordField;
}

- (UIButton *)goButton
{
    if (!_goButton)
    {
        _goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_goButton setTitle:@"Go" forState:UIControlStateNormal];
        _goButton.frame = self.defaultFrame;
        _goButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_goButton];
        
        [self.layouts addLayout:NGLayoutEqual(_goButton, self.passwordField, HEIGHT)];
        [self.layouts addLayout:NGLayoutAlignRight(_goButton, self.passwordField)];
        [self.layouts addLayout:NGLayoutFromBottom(_goButton, self.passwordField, 24.f)];
    }
    
    return _goButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL shouldReturn = NO;
    if ([textField isEqual:self.usernameField])
    {
        [self.passwordField becomeFirstResponder];
    }
    else if ([textField isEqual:self.passwordField])
    {
        [self.passwordField resignFirstResponder];
        shouldReturn = YES;
    }
    else
    {
        assert(0);
    }
    return shouldReturn;
}

@end
