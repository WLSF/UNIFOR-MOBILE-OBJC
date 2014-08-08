//
//  DetalhesNoticiaViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetalhesNoticiaViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIImageView * imagem;
@property (nonatomic, strong) IBOutlet UILabel * titulo;
@property (nonatomic, strong) IBOutlet UITextView * conteudo;

@property (nonatomic, strong) NSDictionary * noticia;

@end
