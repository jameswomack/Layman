//
//  NGViewController.m
//  Layman
//
//  Created by James Womack on 5/19/13.
//  Copyright (c) 2013 Noble Gesture. All rights reserved.
//

#import "NGViewController.h"
#import "NGLayoutSet.h"
#import "NGAppearance.h"
#import "NSArray+Any.h"

@interface NGViewController ()
@property (nonatomic, strong) UITextField *usernameField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *goButton;
@property (nonatomic, strong) NGLayoutSet *layouts;
@end

@implementation NGViewController

@synthesize usernameField = _usernameField, passwordField = _passwordField, goButton = _goButton;
NGDynamic(layouts, NGLayoutSet);


- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [self usernameField];
    [self passwordField];
    [self goButton];
    [self.layouts applyToView:self.view];
    
    NSLog(@"%@",self.aTextFieldIsFirstResponder?@"YES":@"NO");
}

- (UITextField *)usernameField
{
    if (!_usernameField)
    {
        _usernameField = UITextField.new;
        _usernameField.borderStyle = UITextBorderStyleRoundedRect;
        _usernameField.delegate = self;
        _usernameField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_usernameField];
        
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, AL_CENTER_X, AL_LESS_OR, CERO)];
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, AL_TOP, AL_LESS_OR, DEFAULT_TOP_MARGIN)];
        [self.layouts addLayout:NGLayoutInSuperview(_usernameField, AL_WIDTH, AL_EQUAL, -DEFAULT_EDGE_INSET)];
        [self.layouts applyToView:_usernameField.superview];
    }
    
    return _usernameField;
}

- (UITextField *)passwordField
{
    if (!_passwordField)
    {
        _passwordField = UITextField.new;
        _passwordField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordField.delegate = self;
        _passwordField.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_passwordField];
        
        [self.layouts addLayout:NGLayoutEqual(_passwordField, self.usernameField, AL_HEIGHT)];
        [self.layouts addLayout:NGLayoutInSuperview(_passwordField, AL_CENTER_X, AL_LESS_OR, CERO)];
        [self.layouts addLayout:NGLayoutInSuperview(_passwordField, AL_WIDTH, AL_EQUAL, -DEFAULT_EDGE_INSET)];
        [self.layouts addLayout:NGLayoutFromBottom(_passwordField, self.usernameField, DEFAULT_TOP_MARGIN)];
    }
    
    return _passwordField;
}

- (UIButton *)goButton
{
    if (!_goButton)
    {
        _goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [_goButton setTitle:@"Go" forState:UIControlStateNormal];
        _goButton.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.view addSubview:_goButton];
        
        [self.layouts addLayout:NGLayoutAlignRight(_goButton, self.passwordField)];
        [self.layouts addLayout:NGLayoutFromBottom(_goButton, self.passwordField, DEFAULT_TOP_MARGIN)];
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

- (BOOL)aTextFieldIsFirstResponder
{   
    return [[@[self.usernameField, self.passwordField] any] isFirstResponder];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%@",self.aTextFieldIsFirstResponder?@"YES":@"NO");
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%@",self.aTextFieldIsFirstResponder?@"YES":@"NO");
}

@end
