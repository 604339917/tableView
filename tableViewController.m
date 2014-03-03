
#import "tableViewController.h"

//import the tablecekkcell class so we have access to its class variables here.
#import "TableCekkCell.h"
#import "ViewController1.h"


@interface tableViewController ()

@end

@implementation tableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //lets init and alloc memory for our tableViewController class variables as we are about to use them.
    
    _Title = [[NSMutableArray alloc]init];
    _Description = [[NSMutableArray alloc]init ];
    _Price = [[NSMutableArray alloc]init ];
    _Image = [[NSMutableArray alloc]init ];

    
    //Lets parse some JSON from our web service, serialise it (which puts it into an array with nested NSDictionarys.
    
    NSURL *jakesURL = [NSURL URLWithString: @"http://10.1.1.2:3000/products.json"];
    
    NSData* data = [NSData dataWithContentsOfURL:jakesURL];
    
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:0];

    
    //Now lets loop through our arrays (which contain nested key-value NSDictionarys). We will deconstruct the NSDictionary by giving keys and expect values back using the NSDictionarys instance method "Object for Key".
    
    //We will take these results and add them one by one into our NSMutableArray class variables! We have to keep in mind we cannot store primitive variables (like ints) in arrays, so we need to convert the 'price' to a string representation and store that in the array.

    for (NSDictionary * new in json)
    {
        [_Description addObject:[new objectForKey:@"description"]];
        [_Title addObject:[new objectForKey:@"name"]];
        
        NSString * price = [NSString stringWithFormat:@"$%@.00", [new objectForKey:@"price"]];
        
        [_Price addObject: price];
        [_Image addObject:[new objectForKey:@"image"]];
        
    }
  
}
    


//required for a data source..
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // specify the number of sections (groups) in the table view.
    return 1;
}



//required for a data source..
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows *in* the section. We are just going to run a count on one of our tableViewController class arrays.
    
    return _Title.count;
}




// for each cell of the table view, what do you want to do?

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //specify the cell identifer set forth in the storyboard file.
    static NSString *CellIdentifier = @"TableCell";
    
    //we also specify the class of the cell, also set in the storyboard file.
    TableCekkCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    //finally, what do we want to happen in each cell??
    
    //get the index number for the row (starts @ 0)
    int row = [indexPath row];
    
    //lets access the variables inside the TableCekkCell class and give them content from our arrays (_Title, _Description, _Price, _Image) (keep in mind this method we are in is run for each cell in the table).
    
    
    cell.TitleLabel.text = _Title[row];
    cell.DescriptionLabel.text = _Description[row];
    cell.PriceLabel.text = _Price[row];
    
    //interpret the string representation of the URLs stored in the db and covert to a NSURL object (which is what UIImage objects require)
    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:_Image[row]]]];
    
    return cell;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    ViewController1 *detailviewcontroller = [segue destinationViewController];
    
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    
    int row = [myIndexPath row];
    
    detailviewcontroller.DetailModal = @[_Title [row], _Description [row], _Price [row], _Image [row]];
}


@end
