//
//  PerfilViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "PerfilViewController.h"
#import "MKNetworkKit.h"
#import "NotasViewController.h"

@interface PerfilViewController ()

@end

@implementation PerfilViewController

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
    
    NSDictionary * param = @{@"token":self.token};
    
    MKNetworkEngine * engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation * op = [engine operationWithURLString:@"http://www.deway.com.br/treinamentos/ios/perfil.php" params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString * responseString = [completedOperation responseString];
        NSDictionary * retorno = [responseString propertyList];
        
        if ([[retorno objectForKey:@"resultado"] isEqualToString:@"sucesso"]) {
        
            [self.nomeLabel setText:[retorno objectForKey:@"nome"]];
            [self.matriculaLabel setText:[retorno objectForKey:@"matricula"]];
            
            NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[retorno objectForKey:@"foto"]]];
            
            [self.perfilImagem setImage:[UIImage imageWithData:data]];
            
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Senha ou matricula incorretas." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"não foi possivel estabelecer uma conexão" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];
    
    [engine enqueueOperation:op];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onNotasButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"notas" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"notas"]) {
        NotasViewController * notas = segue.destinationViewController;
        notas.token = self.token;
    }
}
@end
