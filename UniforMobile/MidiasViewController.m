//
//  MidiasViewController.m
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import "MidiasViewController.h"
#import "VideosCell.h"
#import "DetalhesMidiaViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MKNetworkKit.h"

@interface MidiasViewController ()

@end

@implementation MidiasViewController

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
    
    self.valores = [[NSArray alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://www.deway.com.br/treinamentos/ios/midia.plist"]];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(atualizarVideos:) forControlEvents:UIControlEventValueChanged];
    
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
    /*VideosCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    NSDictionary * midia = [self.valores objectAtIndex:indexPath.row];
    
    [cell.titulo setText:[midia objectForKey:@"titulo"]];
    [cell.tempo setText:[midia objectForKey:@"duracao"]];
    
    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[midia objectForKey:@"imagem"]]];
    
    [cell.imagem setImage:[UIImage imageWithData:data]];*/
    
    NSDictionary * midia = [self.valores objectAtIndex:indexPath.row];
    
    VideosCell * cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    [cell.titulo setText:[midia objectForKey:@"titulo"]];
    [cell.tempo setText:[midia objectForKey:@"duracao"]];
    
    [cell.imagem sd_setImageWithURL:[NSURL URLWithString:[midia objectForKey:@"imagem"]]];

    /*
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                 [NSURL URLWithString:[midia objectForKey:@"imagem"]]]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.imagem setImage:image];
            
            [cell setNeedsLayout];
        });
    });
    */
    return cell;
}


- (void)atualizarVideos:(id)sender {
    /*dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.valores = [[NSArray alloc]initWithContentsOfURL:[NSURL URLWithString:@"http://www.deway.com.br/treinamentos/ios/midia.plist"]];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [sender endRefreshing];
        });
    });*/
    
    MKNetworkEngine * engine = [[MKNetworkEngine alloc] init];
    MKNetworkOperation * op = [engine operationWithURLString:@"http://www.deway.com.br/treinamentos/ios/midia.plist"];
    
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detalhesMidia"]) {
        DetalhesMidiaViewController * destino = segue.destinationViewController;
        NSIndexPath * indexPath = [self.tableView indexPathForSelectedRow];
        destino.midia = [self.valores objectAtIndex:indexPath.row];
    }
}

@end
