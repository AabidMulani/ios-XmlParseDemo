//
//  ViewController.m
//  xmlDemo
//
//  Created by Magneto on 2/27/14.
//  Copyright (c) 2014 Magneto. All rights reserved.
//

#import "ViewController.h"
#import "GDataXMLNode.h"
@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITableView *myTableView;

@end

@implementation ViewController
@synthesize myTableView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    arrOfCafeNames=[[NSMutableArray alloc]init];

    //Get The Data
    NSString *strUrl=[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/xml?location=18.510052,73.81422&radius=1000&types=food&sensor=false&key=AIzaSyDV4nV2YbyreiMGV4f3Ja8R8XPkRN6nOMw"];
    NSURL *url=[NSURL URLWithString:strUrl];
    
    NSData *xmlData=[NSData dataWithContentsOfURL:url];
    
    //NSLog(@"XMLDATA::::::%@",xmlData);
    
    //Parse Data
    NSError *err;
    GDataXMLDocument *doc=[[GDataXMLDocument alloc]initWithData:xmlData options:0 error:&err];
    NSArray *arrOfNames=[doc nodesForXPath:@"//PlaceSearchResponse/result" error:&err];
    NSLog(@"Arr>>>%@",arrOfNames);
    
    ///Display
    for (GDataXMLElement *name in arrOfNames)
    {
        NSLog(@"Data:%@",name);
//        [arrOfCafeNames addObject:name.stringValue];
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrOfCafeNames.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text=arrOfCafeNames[indexPath.row];
    return cell;
}
@end
