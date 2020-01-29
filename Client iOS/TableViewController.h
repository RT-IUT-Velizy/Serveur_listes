//
//  TableViewController.h
//  TableApp
//
//  Created by Théo on 05/01/2020.
//  Copyright © 2020 Théo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;


@property (weak, nonatomic) IBOutlet UIButton *Envoi;
- (IBAction)Envoi:(id)sender;


@end
