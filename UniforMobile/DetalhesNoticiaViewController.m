//
//  DetalhesNoticiaViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "DetalhesNoticiaViewController.h"

@interface DetalhesNoticiaViewController ()

@end

@implementation DetalhesNoticiaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if (self.noticia != nil) {
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.noticia objectForKey:@"imagem"]]];
        
        [self.imagem setImage:[UIImage imageWithData:data]];
        [self.titulo setText:[self.noticia objectForKey:@"titulo"]];
        [self.conteudo setText:[self.noticia objectForKey:@"conteudo"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
