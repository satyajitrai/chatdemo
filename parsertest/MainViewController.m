//
//  MainViewController.m
//  parsertest
//
//  Created by Satyajit Rai on 7/15/14.
//  Copyright (c) 2014 Yahoo. All rights reserved.
//

#import "MainViewController.h"
#import <Parse/Parse.h>

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *messageText;
- (IBAction)onGo:(UIButton *)sender;
@property (strong, nonatomic) PFUser *user;
@property (strong, nonatomic) NSArray *messages;

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.user = [PFUser currentUser];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadMessages];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadMessages
{
    PFQuery *query = [PFQuery queryWithClassName:@"Messages"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        self.messages = objects;
    }];
}

- (IBAction)onGo:(UIButton *)sender {
    
    PFObject *message = [PFObject objectWithClassName:@"Message"];
    message[@"text"] = self.messageText.text;
    message[@"user"] = self.user.username;
    [message saveInBackground];
}

#pragma mark method for table view
- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messages.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"load messages");
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.text = self.messages[indexPath.row][@"text"];
    return cell;
}


@end
