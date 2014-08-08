//
//  NoticiasViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 05/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticiasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * valores;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl * refreshControl;
@end
