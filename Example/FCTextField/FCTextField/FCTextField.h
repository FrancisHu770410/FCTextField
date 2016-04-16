//
//  FCTextField.h
//  TestTextField
//
//  Created by 胡珀菖 on 2016/4/16.
//  Copyright © 2016年 胡珀菖. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FCTextFieldDidFinishedPhoneNumberDelegate <NSObject>

@required
- (void) textFieldDidReceivedPhoneNumber:(NSString*)phoneNumber displayPhoneString:(NSString*)displayPhoneString;

@end

@interface FCTextField : UITextField

@property (nonatomic, weak) id<FCTextFieldDidFinishedPhoneNumberDelegate> phoneNumberDelegate;

@end
