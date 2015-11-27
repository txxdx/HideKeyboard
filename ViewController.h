//
//  ViewController.h
//  HideKeyboard
//
//  Created by huangxiaobin on 11/27/15.
//  Copyright © 2015 huangxiaobin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, weak) IBOutlet UITextField *usernameTF;
@property (nonatomic, weak) IBOutlet UITextField *passwordTF;

- (IBAction)hideKeyboardByTouchView:(id)sender;
- (IBAction)hideKeyboardByReturn:(id)sender;

@end

