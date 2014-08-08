//
//  loginViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "loginViewController.h"
#import "MKNetworkKit.h"
#import "PerfilViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLoginButtonClick:(id)sender {
    NSDictionary * param = @{@"matricula":[self.idText text], @"senha":[self.passText text]};
    
    MKNetworkEngine * engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation * op = [engine operationWithURLString:@"http://www.deway.com.br/treinamentos/ios/login.php" params:param httpMethod:@"POST"];

    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString * responseString = [completedOperation responseString];
        NSDictionary * retorno = [responseString propertyList];
        
        if ([[retorno objectForKey:@"resultado"] isEqualToString:@"sucesso"]) {
            self.token = [retorno objectForKey:@"token"];
            
            [self performSegueWithIdentifier:@"login" sender:self];
        } else {
            [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Senha ou matricula incorretas." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"não foi possivel estabelecer uma conexão" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }];

    [engine enqueueOperation:op];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"login"]) {
        PerfilViewController * perfil = segue.destinationViewController;
        perfil.token = self.token;
    }
}
@end
