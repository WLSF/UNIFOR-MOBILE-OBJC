//
//  NotasViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "NotasViewController.h"
#import "MKNetworkKit.h"

@interface NotasViewController ()

@end

@implementation NotasViewController

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
    MKNetworkOperation * op = [engine operationWithURLString:@"http://www.deway.com.br/treinamentos/ios/notas.php" params:param httpMethod:@"POST"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString * responseString = [completedOperation responseString];
        NSDictionary * retorno = [responseString propertyList];
        
        if ([[retorno objectForKey:@"resultado"] isEqualToString:@"sucesso"]) {
            
            self.notas = [[NSArray alloc] initWithArray:[retorno objectForKey:@"notas"]];
            
            
            [self.tableView reloadData];
            
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.notas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * nota = [self.notas objectAtIndex:indexPath.row];
    
    [cell.textLabel setText:[nota objectForKey:@"disciplina"]];
    
    return cell;
}

@end
