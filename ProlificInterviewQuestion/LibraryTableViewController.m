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

static NSString * const BaseURLString = @"http://prolific-interview.herokuapp.com/54be71eb46c2c2000866aa56?";

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
//    NSURL *url = [[NSURL alloc]initWithString:BaseURLString];
//    NSString *getBooksString = [BaseURLString stringByAppendingString:@"/books"];
//    NSURL *url2 = [[NSURL alloc]initWithString:getBooksString];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    //=====================================================================================================================================
    
//    //ok. this is the code that gives me data for the page. but it doesnt give me the JSON I need
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"success: %@", operation.responseString);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"error: %@",  operation.responseString);
//    }];
//    
//    [operation start];
    
    //=====================================================================================================================================

    
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url2];
//    
//    __block NSDictionary *json;
//    [NSURLConnection sendAsynchronousRequest:request
//                                       queue:[NSOperationQueue mainQueue]
//                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//                               json = [NSJSONSerialization JSONObjectWithData:data
//                                                                      options:0
//                                                                        error:nil];
//                               NSLog(@"Async JSON: %@", json);
//                           }];

    //=====================================================================================================================================

    
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = securityPolicy;
    //manager.responseSerializer.acceptableContentTypes = manager.responseSerializer.acceptableContentTypes;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    [manager GET:[NSString stringWithFormat:@"%@", BaseURLString] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
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
    
    //=====================================================================================================================================

    
    //this is for getting the HTTP data- which is the data from the webpage
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURL * url = [NSURL URLWithString:BaseURLString];
    
    NSURLSessionDataTask * dataTask = [delegateFreeSession dataTaskWithURL:url
                                                         completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                             
                                                             if(error == nil)
                                                             {
                                                                 NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                                 NSLog(@"Data = %@",text);
                                                                 
                                                                 
                                                                 NSMutableDictionary *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableLeaves error: &error];
                                                                 
                                                                 if (!jsonArray) {
                                                                     NSLog(@"Error parsing JSON: %@", error);
                                                                 } else {
                                                                     
                                                                     NSLog(@"resp: %@ = %@",[jsonArray objectForKey:@"books"],[jsonArray objectForKey:@"books"]);
                                                                     NSLog(@"Dictionary count: %lu", jsonArray.count);
                                                                 }
                                                                 
                                                             }
                                                             
                                                         }];
    
    [dataTask resume];
    
    
    
    //=====================================================================================================================================

    //    NSString *requestString = [NSString stringWithFormat:@"%@/v/%@.json", hostName, apptIDHash];
    
//    NSURL *url = [NSURL URLWithString:BaseURLString];
//    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:url];
//    
//    NSURLSessionDataTask *dataTask = [NSURLSessionDataTask dataTaskWithRequest:req completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
//        
//        if (!error) {
//            NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
//            if (httpResp.statusCode == 200) {
//                NSError *jsonError;
//                NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
//                //[self printJSONOutputFromDictionary:jsonObject];
//                if (!jsonError) {
//                    block(jsonObject, nil);
//                }
//                else{
//                    block(nil, jsonError);
//                }
//            }
//            else{
//                NSError *statusError = [self createServerUnavailableNSError:httpResp];
//                block(nil, statusError);
//            }
//        }
//        else{
//            block(nil, error);
//        }
//    }];
//    
//    [dataTask resume];
//    
    
    //=====================================================================================================================================

    
//    // Setup the session
//    NSURLSessionConfiguration * configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
//    NSURLSession * session = [NSURLSession sessionWithConfiguration:configuration];
//    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:BaseURLString]];
//    
//    // Create a data task to transfer the web service endpoint contents
//    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request
//                                                 completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//        
//        // Stop the refresh control
//        [self.refreshControl endRefreshing];
//        if (error)
//        {
//            self.title = error.localizedDescription;
//            return;
//        }
//        
//        // Parse the JSON from the data object
//        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
//
//        if (!json) {
//            NSLog(@"Error parsing JSON: %@", error);
//        } else {
//            for(NSDictionary *item in json) {
//                NSLog(@"Item: %@", item);
//            }
//        }
////        // Store off the top level array of forecasts
////        items = json[@"list"];
//        
//        [self.tableView reloadData];
//    }];
//    
//    // Start the download task
//    [dataTask resume];



}




/* The task has received a response and no further messages will be
 * received until the completion block is called. The disposition
 * allows you to cancel a request or to turn a data task into a
 * download task. This delegate message is optional - if you do not
 * implement it, you can get the response as a property of the task.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

/* Sent when data is available for the delegate to consume.  It is
 * assumed that the delegate will retain and not copy the data.  As
 * the data may be dis-contiguous, you should use
 * [NSData enumerateByteRangesUsingBlock:] to access it.
 */
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data
{
    //data: response from the server.
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
