//
//  FCTextField.m
//  TestTextField
//
//  Created by 胡珀菖 on 2016/4/16.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

#import "FCTextField.h"

@interface FCTextField() <UITextFieldDelegate>

@property (nonatomic, strong) NSString *firstString;
@property (nonatomic, strong) NSString *secondString;
@property (nonatomic, strong) NSString *thirdString;

@property (nonatomic) BOOL removeToThree;
@property (nonatomic) BOOL removeToSeven;
@property (nonatomic) BOOL isCut;
@property (nonatomic) BOOL isMiddle;
@property (nonatomic) BOOL cutDash;

@property (nonatomic, strong) NSString *tempDisplayResult;

@end

@implementation FCTextField

- (instancetype) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _removeToThree = false;
        _removeToSeven = false;
        _isCut = false;
        _cutDash = false;
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return self;
}

- (void) textFieldDidChange:(UITextField*)textField {
    UITextRange *selRange = (_isCut || _isMiddle || _cutDash) ? textField.selectedTextRange : nil;

    if (textField.text.length > 12) {
        
        textField.text = self.tempDisplayResult;
        self.tempDisplayResult = nil;
    }
    
    if (self.removeToSeven) {
        textField.text = [textField.text substringToIndex:7];
        _cutDash = false;
    } else if (self.removeToThree) {
        textField.text = [textField.text substringToIndex:3];
        _cutDash = false;
    }
//    3,1 7,1
    _removeToSeven = false;
    _removeToThree = false;
    
    NSRange checkDashLocation = [textField.text rangeOfString:@"-"];
    
    NSString *tempNumberText = [[textField.text stringByReplacingOccurrencesOfString:@"-" withString:@""] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    if (_cutDash) {
        tempNumberText = (checkDashLocation.location < textField.text.length) ? [tempNumberText stringByReplacingCharactersInRange:NSMakeRange(7, 1) withString:@""] : [tempNumberText stringByReplacingCharactersInRange:NSMakeRange(3, 1) withString:@""];
    }
    
    _cutDash = false;
    
    self.thirdString = (tempNumberText.length > 7) ? [tempNumberText substringFromIndex:7] : nil;
    self.firstString = (tempNumberText.length > 4) ? [tempNumberText substringToIndex:4] : tempNumberText;
    
    if (self.thirdString) {
        self.secondString = [tempNumberText substringWithRange:NSMakeRange(4, 3)];
    } else if (self.firstString.length >= 4) {
        self.secondString = (tempNumberText.length < 5) ? nil : [tempNumberText substringFromIndex:4];
    } else {
        self.secondString = nil;
    }
    
    NSString *phoneNumber = [NSString stringWithFormat:@"%@%@%@", self.firstString, self.secondString, self.thirdString];
    if (self.phoneNumberDelegate && phoneNumber.length == 10) {
        NSString *phoneNumberString = [NSString stringWithFormat:@"%@-%@-%@", self.firstString, self.secondString, self.thirdString];
        [self.phoneNumberDelegate textFieldDidReceivedPhoneNumber:phoneNumber displayPhoneString:phoneNumberString];
        self.tempDisplayResult = phoneNumber;
    }
 
    if (self.thirdString.length > 0) {
        textField.text = [NSString stringWithFormat:@"%@-%@-%@", self.firstString, self.secondString, self.thirdString];
    } else if (self.secondString.length > 0) {
        textField.text = (self.secondString.length == 3) ? [NSString stringWithFormat:@"%@-%@-", self.firstString, self.secondString] : [NSString stringWithFormat:@"%@-%@", self.firstString, self.secondString];
    } else {
        textField.text = (self.firstString.length == 4) ? [NSString stringWithFormat:@"%@-", self.firstString] : [NSString stringWithFormat:@"%@", self.firstString]; ;
    }
    
    if (selRange) {
        [textField setSelectedTextRange:selRange];
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (range.length > 0) {
        _removeToSeven = (textField.text.length == 9);
        _removeToThree = (textField.text.length == 5);
        _isCut = true;
        _cutDash = ([[textField.text substringWithRange:NSMakeRange(range.location, 1)] isEqualToString:@"-"]);
    } else {
        _isMiddle = (range.location != textField.text.length);
        _isCut = false;
        _removeToSeven = false;
        _removeToThree = false;
        _cutDash = false;
    }
    
    if (textField.text.length <= 12) {
        self.tempDisplayResult = textField.text;
        return true;
    } else {
        return false;
    }
    
}

@end
