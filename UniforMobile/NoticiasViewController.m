//
//  NoticiasViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 05/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "NoticiasViewController.h"
#import "WillianTableCell.h"
#import "DetalhesNoticiaViewController.h"
#import "MKNetworkKit.h"
#import "SDWebImage/UIImageView+WebCache.h"

@interface NoticiasViewController ()

@end

@implementation NoticiasViewController

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
    
    
    //NSString * file = [[NSBundle mainBundle] pathForResource:@"noticias" ofType:@"plist"];
    //self.valores = [[NSArray alloc] initWithContentsOfFile:file];
    self.valores = [[NSArray alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://www.deway.com.br/treinamentos/ios/noticias.plist"]];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(atualizarNoticias:) forControlEvents:UIControlEventValueChanged];
    
    [self.tableView addSubview:self.refreshControl];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.valores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WillianTableCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * temp = [self.valores objectAtIndex:indexPath.row];
    
    //NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[temp objectForKey:@"imagem"]]];
    
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd/MM"];
    
    NSString * date = [format stringFromDate:[temp objectForKey:@"publicacao"]];

    //[cell.imageNews setImage:[UIImage imageWithData:data]];
    [cell.titleNews setText:[NSString stringWithFormat:@"%@ - %@", date, [temp objectForKey:@"titulo"]]];
    [cell.contentNews setText:[temp objectForKey:@"conteudo"]];
    
    
    [cell.imageNews sd_setImageWithURL:[temp objectForKey:@"imagem"]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detalhesNoticia"]) {        
        DetalhesNoticiaViewController * destino = segue.destinationViewController;
        NSIndexPath * index = [self.tableView indexPathForSelectedRow];
        destino.noticia = [self.valores objectAtIndex:index.row];
        
    }
}

- (void)atualizarNoticias:(id)sender {
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.valores = [[NSArray alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.deway.com.br/treinamentos/ios/noticias.plist"]];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [sender endRefreshing];
        });
    });*/
    
    
    MKNetworkEngine * engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation * op = [engine operationWithURLString:@"http://www.deway.com.br/treinamentos/ios/noticias.plist"];
    
    [op addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString * responseString = [completedOperation responseString];
        
        self.valores = [responseString propertyList];
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
        
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Erro" message:@"Sem conexão" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
        
        [self.refreshControl endRefreshing];
    }];
    
    [engine enqueueOperation:op];
}

@end
