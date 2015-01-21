//
//  LibraryTableViewController.m
//  ProlificInterviewQuestion
//
//  Created by Henry Savit on 1/20/15.
//  Copyright (c) 2015 Henry Savit. All rights reserved.
//

#import "LibraryTableViewController.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "Books.h"

static NSString * const BaseURLString = @"http://prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56";

@interface LibraryTableViewController ()

@property (strong, nonatomic) NSArray *booksFromAFNetworking;
@property(strong) NSDictionary *library;

@end

@implementation LibraryTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self makeLibraryRequests];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

-(void)makeLibraryRequests
{
    NSString *getBooksString = [BaseURLString stringByAppendingString:@"/books.json"];
    NSURL *url = [[NSURL alloc]initWithString:getBooksString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:getBooksString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@", responseObject);
        NSArray *jsonArray = (NSArray *)responseObject;
        NSMutableArray *tempBooks = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in jsonArray) {
            Books *book = [[Books alloc] initWithDictionary:dic];
            [tempBooks addObject:book];
        }
        
        
        self.booksFromAFNetworking = [[NSArray alloc] initWithArray:tempBooks];
        tempBooks = nil;
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Books"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];

    
    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer.acceptableContentTypes = operation.responseSerializer.acceptableContentTypes;
//    //operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/json"];
//
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        NSLog(@"%@", responseObject);
//        NSArray *jsonArray = (NSArray *)responseObject;
//        NSMutableArray *tempBooks = [[NSMutableArray alloc] init];
//        
//        for (NSDictionary *dic in jsonArray) {
//            Books *book = [[Books alloc] initWithDictionary:dic];
//            [tempBooks addObject:book];
//        }
//        
//        
//        self.booksFromAFNetworking = [[NSArray alloc] initWithArray:tempBooks];
//        tempBooks = nil;
//        
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Books"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    [operation start];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.booksFromAFNetworking count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSDictionary *tempDictionary= [self.booksFromAFNetworking objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempDictionary objectForKey:@"Title"];
    
    if([tempDictionary objectForKey:@"rating"] != NULL)
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ ",[tempDictionary   objectForKey:@"Author"]];
    }
    else
    {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"No Author"];
    }
    
    return cell;
}

@end
