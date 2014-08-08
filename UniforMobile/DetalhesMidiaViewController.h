//
//  DetalhesMidiaViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPlayer/MediaPlayer.h"

@interface DetalhesMidiaViewController : UIViewController

@property (nonatomic, strong) NSDictionary * midia;

@property (nonatomic, strong) MPMoviePlayerController * controller;

@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UITextView *conteudo;
@property (retain, nonatomic) UIImageView * imagem;

@end
