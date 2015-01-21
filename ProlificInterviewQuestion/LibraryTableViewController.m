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
    NSURL *url = [[NSURL alloc]initWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    //operation.responseSerializer = [AFJSONResponseSerializer serializer];
    operation.responseSerializer.acceptableContentTypes = [operation.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];

    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    [operation start];
    
    // 1
//    NSString *string = [NSString stringWithFormat:@"%@books.php?format=json", BaseURLString];
//    NSURL *url = [NSURL URLWithString:string];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    operation.responseSerializer = [AFJSONResponseSerializer serializer];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        // 3
//        self.library = (NSDictionary *)responseObject;
//        self.title = @"JSON Retrieved";
//        [self.tableView reloadData];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//        // 4
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
//                                                            message:[error localizedDescription]
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"Ok"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }];
//    
//    // 5
//    [operation start];
    
    
//    [manager GET:@"books" parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"JSON: %@", responseObject);
//        //self.booksFromAFNetworking = [responseObject objectForKey:@"title"];
//        
//        //NSLog(@"The Array: %@",self.booksFromAFNetworking);
//        
//        [self.tableView reloadData];
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"Error: %@", error);
//    }];
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
