# iOS键盘隐藏的几种方法

---

## 1. Overview
在开发App的过程中，经常要求用户进行输入操作，比如登陆过程中要求输入用户名和密码。但是有可能弹出的keyboard把登陆button挡住了，从而无法点击button。
	
## 2. Solutions
可以通过实现隐藏键盘来解决这类问题。隐藏键盘的方法也有好几种，比如利用键盘的return键来实现隐藏，也可以通过点击view上其它的空白处来实现隐藏，或者通过响应自定义手势来隐藏，还可以通过给软键盘增加一个toolbar，在toolbar上面添加按钮来实现隐藏键盘，当然还有其它没有提及的方法。
常用的隐藏键盘的两个方法：

1. *[view endEditing:YES];* 
2. *[textField resignFirstResponder];*

### 2.1 点击View空白处隐藏键盘	
#### 方法一：重写*touchesBegan: withEvent:*方法

```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [[event allTouches] anyObject];
    if ([textField isFirstResponder] && [touch view] != textField) {
        [textField resignFirstResponder];
    }
    [super touchesBegan: touches withEvent: event];
}
```

#### 方法二：
修改xib或storyb中相关view的Custom Class为UIControl（默认是UIView），在UIControl中实现点击隐藏键盘的功能

![UIControl](https://s3.amazonaws.com/f.cl.ly/items/0A372Y2l2w0934062w40/uicontrol.png)

```
//ViewController.h
#import <UIKit/UIKit.h>
@interface ViewController: UIViewController

- (IBAction)hideKeyboardByTouchView:(id)sender;

@end
```

```
//ViewController.m
#import "ViewController.h"

@implemetation ViewController

- (IBAction)hideKeyboardByTouchView:(id)sender {
    [self.view endEiting:YES];
}

@end
```

#### 方法三：添加点击的手势，实现隐藏键盘

```
- (void)tapGestureRecognizerHideKeyboard {
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewEndEditing:)];
	[self.view addGestureRecognizer:tap];
}

- (void)viewEndEditing:(id)sender {
	[self.view endEditing:YES];
}
```

### 2.2 点击return键实现隐藏键盘

通过给textField添加响应*Did End On Exit*事件的方法来实现隐藏keyboard的功能

![](https://s3.amazonaws.com/f.cl.ly/items/1I160Q2U1F2z0i0Q3Q0e/returnKeyboarder.png)

实现隐藏键盘功能的代码

```
- (IBAction)hideKeyboardByReturn:(id)sender {
    [sender resignFirstResponder];
}
```

用这中方法隐藏键盘是有问题，如果有多个textField存在的话，需要为每一个textField添加响应*Did End On Exit*事件的方法，有时候return键可以需要实现其它的功能。

### 2.3 键盘添加一个toolbar，toolbar上添加button来实现隐藏功能

首先看一下效果图

![](https://s3.amazonaws.com/f.cl.ly/items/1x0g381a32130n1L3e0i/keyboardToolbar.png)

实现代码：

```
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

```

## 3.Conclusion
以上简单的实现了隐藏键盘的方法。




