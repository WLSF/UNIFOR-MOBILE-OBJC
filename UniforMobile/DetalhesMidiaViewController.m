//
//  DetalhesMidiaViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "DetalhesMidiaViewController.h"
#import "MediaPlayer/MediaPlayer.h"

@interface DetalhesMidiaViewController ()

@end

@implementation DetalhesMidiaViewController

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
    
    [self.titulo setText:[self.midia objectForKey:@"titulo"]];
    [self.conteudo setText:[self.midia objectForKey:@"conteudo"]];
    
    NSURL * url = [NSURL URLWithString:[self.midia objectForKey:@"url"]];
    
    if ([[self.midia objectForKey:@"tipo"] isEqualToString:@"tv"]) {
    
        self.controller = [[MPMoviePlayerController alloc] initWithContentURL:url];
    
        [self.controller prepareToPlay];
        [self.controller.view setFrame:CGRectMake(10, 70, 300, 190)];
        //[[mp view] setFrame:[[self view] bounds]];
        [self.view addSubview:self.controller.view];
        [self.controller play];
    } else {
        NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[self.midia objectForKey:@"imagem"]]];
        
        self.imagem = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
        
        [self.imagem setFrame:CGRectMake(10, 70, 300, 190)];
        [self.view addSubview:self.imagem];
        
        self.controller = [[MPMoviePlayerController alloc] initWithContentURL:url];
        
        [self.controller prepareToPlay];
        [self.controller.view setFrame:CGRectMake(10, 230, 300, 40)];
        [self.view addSubview:self.controller.view];
        [self.controller play];
    }
    /*MPMoviePlayerViewController * mp = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    mp.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
    [self presentViewController:mp animated:YES completion:^{}];*/
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
