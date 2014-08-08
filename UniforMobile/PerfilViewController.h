//
//  PerfilViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PerfilViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *nomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *matriculaLabel;
@property (weak, nonatomic) IBOutlet UIImageView *perfilImagem;
@property (weak, nonatomic) IBOutlet UIButton *notasButton;

@property (nonatomic, strong) NSString * token;

- (IBAction)onNotasButtonClick:(id)sender;
@end
