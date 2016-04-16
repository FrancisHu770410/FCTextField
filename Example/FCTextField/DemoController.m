//
//  DemoController.m
//  FCTextField
//
//  Created by 胡珀菖 on 2016/4/16.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

#import "DemoController.h"

#import "FCTextField.h"

@interface DemoController () <FCTextFieldDidFinishedPhoneNumberDelegate>

@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    FCTextField *testTextField = [[FCTextField alloc] initWithFrame:CGRectMake(20, 100, CGRectGetWidth(self.view.frame) - 40, 40)];
    testTextField.layer.borderWidth = 1.0;
    testTextField.phoneNumberDelegate = self;
    [self.view addSubview:testTextField];
}

- (void) textFieldDidReceivedPhoneNumber:(NSString *)phoneNumber displayPhoneString:(NSString *)displayPhoneString {
    NSLog(@"%@, %@", phoneNumber, displayPhoneString);
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
