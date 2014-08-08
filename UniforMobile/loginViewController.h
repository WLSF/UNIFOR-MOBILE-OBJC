//
//  loginViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface loginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *passText;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)onLoginButtonClick:(id)sender;

@property (nonatomic, strong) NSString * token;
@end
