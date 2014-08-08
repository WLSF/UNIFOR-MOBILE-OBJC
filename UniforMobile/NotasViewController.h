//
//  NotasViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 08/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NotasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString * token;

@property (nonatomic, strong) NSArray * notas;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
