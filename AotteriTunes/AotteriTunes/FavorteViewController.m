

#import "FavroteViewController.h"
#import "FavroteTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import "Settings.h"

@interface FavroteViewController ()
{
    NSMutableDictionary *dict;
    NSMutableArray *currentRow;
    NSMutableArray *movieRow;
    NSMutableArray *musicRow;
    NSString *searchKey;
    long moiveResultCount,musicResultCount;
    long selectKind;
}
@end

@implementation FavroteViewController

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"@viewDidApper");
    [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
    
    _searchTableView.refreshControl = [[UIRefreshControl alloc] init];
    _searchTableView.refreshControl.backgroundColor = [UIColor purpleColor];
    _searchTableView.refreshControl.tintColor = [UIColor whiteColor];
 
    [self tapSearchBtn];
    
 
        _searchTableView.rowHeight = 190;
    _searchTableView.estimatedRowHeight = 190;//the estimatedRowHeight but if is more this autoincremented with autolayout
    
    [_searchTableView setNeedsLayout];
    [_searchTableView layoutIfNeeded];
}
-(void)reloadData2{
    [self refreshTable];
}

- (void)refreshTable {
    //TODO: refresh your data
    [self->_searchTableView.refreshControl endRefreshing];
    [self.searchTableView reloadData];
}


- (void)tapSearchBtn
{
 
        [self praseSearch];
//        [self.searchTableView setNeedsLayout];
//        [self.searchTableView layoutIfNeeded];
//        [self->_searchTableView.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
        //    [_searchTableView setHidden:NO];
//    }
}
- (IBAction)tapSegment:(id)sender {
    selectKind = _itemSegmentControl.selectedSegmentIndex;
    NSLog(@"%ld" , selectKind);
    [self reloadData2];
}

-(void)praseSearch
{

    
    NSMutableArray *removedData =  [NSMutableArray array];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesLoaded = [defaults objectForKey:@"favorites"];

        NSMutableArray *favorites = [NSMutableArray array];

       if (favoritesLoaded) {
            favorites = [[NSMutableArray alloc] initWithArray:favoritesLoaded];
        } else {
            favorites = [[NSMutableArray alloc] init];
        }
 
//
        long count = favorites.count;
    
    // After your loop
    removedData = [[NSMutableArray alloc] init];
    [removedData removeAllObjects];
    
        for (int i=0 ;i<count ;i++)
        {
            
//            _trackViewUrl, @"trackViewUrl",
//            _lblTrackName.text, @"trckName",
//            _lblAristName.text, @"aristName",
//            _lblCollectionName.text, @"collectionName",
//            _lblLength.text, @"length",
//            _lblLongDescription.text, @"longDescription",
//
             NSLog(@">=[%i] %@",i,favorites[i]);
            
            NSLog(@">[%i] %@",i,favorites[i][@"kind"]);
            NSLog(@">[%i] %@",i,favorites[i][@"aristName"]);
            NSLog(@">[%i] %@",i,favorites[i][@"trckName"]);
            NSLog(@">[%i] %@",i,favorites[i][@"trackViewUrl"]);
            NSLog(@">[%i] %@",i,favorites[i][@"CollectionViewUrl"]);
            
 
            if([favorites[i][@"kind"]  isEqual: @"feature-movie"])
            {
                [removedData addObject: favorites[i] ];
                movieRow = [NSMutableArray arrayWithArray:removedData];
                moiveResultCount ++;
            }
            else
            {   [removedData addObject: favorites[i] ];
                [musicRow addObject: favorites[i]];
                musicRow= [NSMutableArray arrayWithArray:removedData];
                musicResultCount ++;
            }
        }
    
    
    NSLog(@"movie,music:%ld %ld",moiveResultCount,musicResultCount);

        NSLog(@"*-remove favIDed");
 
    favoritesLoaded = [defaults objectForKey:@"favorites"];
    NSLog(@"*- than real favcount:%ld",(long) favoritesLoaded.count );
 
    
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (selectKind == 0)
    return moiveResultCount;
    else if (selectKind == 1)
    return musicResultCount;
    else
    return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  
    return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavroteTableViewCell *cell = [FavroteTableViewCell new];
    if (selectKind == 0)
    {
        if (self->moiveResultCount > 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
            NSString *url = movieRow[indexPath.row][@"artworkUrl60"];
            //               NSLog(@"url: %@",url);
            [cell.imgPicture sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Pichoder"]];
            cell.lblTrackName.text = movieRow[indexPath.row][@"trckName"];
            cell.lblAristName.text = movieRow[indexPath.row][@"aristName"];
            cell.lblCollectionName.text = movieRow[indexPath.row][@"collectionName"];
//            long h,m,s,tt;
            NSString *fmtString =  movieRow[indexPath.row][@"length"];
//            m = tt %3600 /60;
//            s = tt % 60;
         
            cell.lblLength.text = fmtString;
 
            //-- favroite
            
            cell.kind = movieRow[indexPath.row][@"kind"];
            cell.trackViewUrl = movieRow[indexPath.row][@"trackViewUrl"];
          
            long lTrackId= [movieRow[indexPath.row][@"trackId"] longValue];
            NSString *strTarckId =  [NSString stringWithFormat:@"%ld",lTrackId];
            cell.trackId = lTrackId ;
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *favIdSaved= [defaults objectForKey: strTarckId ];
            NSLog(@"%@",favIdSaved);
            if (favIdSaved == NULL)     //目前為未收藏
            {
                [cell.btnFavorte setTitle:@"收藏" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnFavorte setTitle:@"取消收藏" forState:UIControlStateNormal];
            }
            //--
//            [cell.btnReadMore setHidden:NO];
            
        }
        else{
            NSLog(@"-moiveResultCount <= 0");
        }
        [cell reloadInputViews];
    }else{
        if (self->musicResultCount> 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"Cell2" forIndexPath:indexPath];
            NSString *url = musicRow[indexPath.row][@"artworkUrl60"];
            //               NSLog(@"url: %@",url);
            [cell.imgPicture sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Pichoder"]];
            cell.lblTrackName.text = musicRow[indexPath.row][@"trckName"];
            cell.lblAristName.text = musicRow[indexPath.row][@"aristName"];
            cell.lblCollectionName.text = musicRow[indexPath.row][@"collectionName"];
            //            long h,m,s,tt;
            NSString *fmtString =  musicRow[indexPath.row][@"length"];
            //            m = tt %3600 /60;
            //            s = tt % 60;
            
            
            //-- favroite
            
            cell.kind = musicRow[indexPath.row][@"kind"];
            cell.trackViewUrl = musicRow[indexPath.row][@"trackViewUrl"];
            
            long lTrackId= [musicRow[indexPath.row][@"trackId"] longValue];
            NSString *strTarckId =  [NSString stringWithFormat:@"%ld",lTrackId];
            cell.trackId = lTrackId ;
            
            cell.lblLength.text = fmtString;
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *favIdSaved= [defaults objectForKey: strTarckId ];
            NSLog(@"%@",favIdSaved);
            if (favIdSaved == NULL)     //目前為未收藏
            {
                [cell.btnFavorte setTitle:@"收藏" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnFavorte setTitle:@"取消收藏" forState:UIControlStateNormal];
            }
        }
        else{
            NSLog(@"-musicResultCount <= 0");
        }
        
    }
    
    return cell;
}

@end
