//
//  ViewController.m
//  HideKeyboard
//
//  Created by huangxiaobin on 11/27/15.
//  Copyright © 2015 huangxiaobin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	[self tapGestureRecognizerHideKeyboard];
	[self addToolbarOnKeyboard:self.passwordTF];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Hide username textField related keyboard
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [[event allTouches] anyObject];
	if ([self.usernameTF isFirstResponder] && [touch view] != self.usernameTF) {
		[self.usernameTF resignFirstResponder];
	}
}

#pragma  mark - Add tap gesture to hide keyboard
- (void)tapGestureRecognizerHideKeyboard {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewEndEditing:)];
	[self.view addGestureRecognizer:tap];
}

- (void)viewEndEditing:(id)sender {
	[self.view endEditing:YES];
}

#pragma mark - Change view custom class to UIControl, and add an IBAction to hide keyboard
- (IBAction)hideKeyboardByTouchView:(id)sender {
	[self.view endEditing:YES];
}

#pragma mark - Add an IBAction to 'return' key to hide keyboard
- (IBAction)hideKeyboardByReturn:(id)sender {
	[sender resignFirstResponder];
}

#pragma mark - Add a toolbar on keyboard 
- (void)addToolbarOnKeyboard:(UITextField *)textField {
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 30)];
	
	UIBarButtonItem *spaceButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hideKeyboard:)];
	
	[toolbar setItems:@[spaceButton, doneButton]];
	textField.inputAccessoryView = toolbar;
}

- (void)hideKeyboard:(id)sender {
	[self.view endEditing:YES];
}

@end
