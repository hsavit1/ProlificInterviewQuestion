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
#import "BookDetailViewController.h"

static NSString * const BaseURLString = @"http://prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56";

@interface LibraryTableViewController (){
    NSArray *items;
}

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showDetail"]){
        NSIndexPath *ind =[[self.tableView indexPathsForSelectedRows] lastObject];
        Books *selectedBook = [[Books alloc]init];
        selectedBook = [self.booksFromAFNetworking objectAtIndex:ind.item];
        ((BookDetailViewController*)segue.destinationViewController).theSelectedBook = selectedBook;
    }
}

-(void)makeLibraryRequests
{
    NSURL *url = [NSURL URLWithString:@"http://prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56/books"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url]; //;]cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
    [request setHTTPMethod:@"GET"];
    //    This is actually how jQuery works. If you don't tell it what to do with the result, it uses the Content-type to detect what to do with it.
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"application/json; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        //parse data here!!
        
        NSError *jsonError;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
        
        if (json) {
            //NSArray *allBooks = [json objectForKey:@"books"];
            
            //create your MutableArray here
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else{
            NSLog(@"error occured %@", jsonError);

            NSString *serverResponse = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
            
            NSLog(@"\n\nError:\n%@\n\nServer Response:\n%@\n\nCrash:", jsonError.description, serverResponse);
            //[NSException raise:@"Invalid Data" format:@"Unable to process web server response."];
        }
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self makeLibraryRequests];
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
    
//    NSDictionary *tempDictionary= [self.booksFromAFNetworking objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = [tempDictionary objectForKey:@"Title"];
//    
//    if([tempDictionary objectForKey:@"rating"] != NULL)
//    {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"Author: %@ ",[tempDictionary   objectForKey:@"Author"]];
//    }
//    else
//    {
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"No Author"];
//    }
    
    return cell;
}

@end
