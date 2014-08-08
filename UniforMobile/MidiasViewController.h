//
//  MidiasViewController.h
//  UniforMobile
//
//  Created by aluno-r17 on 06/08/14.
//  Copyright (c) 2014 aluno-r17. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MidiasViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray * valores;
@property (nonatomic, strong) IBOutlet UITableView * tableView;

@property (nonatomic, strong) UIRefreshControl * refreshControl;
@end
