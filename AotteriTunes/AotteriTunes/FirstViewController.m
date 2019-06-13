
#import "FirstViewController.h"
#import "SearchTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import <SDWebImage/SDWebImage.h>
#import "Settings.h"

@interface FirstViewController () <UISearchBarDelegate>
{
NSMutableDictionary *dict;
NSMutableArray *currentRow;
NSMutableArray *movieRow;
NSMutableArray *musicRow;
    NSString *searchKey;
    long moiveResultCount,musicResultCount;
}
@end

@implementation FirstViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"@viewDidApper");
    [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Initialize the refresh control.
   
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *theme = [defaults objectForKey: @"themset"];
    if ([theme isEqual: @"drak"])
    {
        [[Settings sharedSettings] setThemeColor:UIColor.greenColor];
        [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
    }
    else
    {
        [[Settings sharedSettings] setThemeColor:UIColor.brownColor];
        [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
        
    }
        
    _searchTableView.refreshControl = [[UIRefreshControl alloc] init];
    _searchTableView.refreshControl.backgroundColor = [UIColor purpleColor];
    _searchTableView.refreshControl.tintColor = [UIColor whiteColor];
    [_searchTableView.refreshControl addTarget:self action:@selector(reloadData2) forControlEvents:UIControlEventValueChanged];
    
    
    
    [_searchTableView setHidden:YES];
    _searchTableView.rowHeight = UITableViewAutomaticDimension;
//    _searchTableView.rowHeight = 190;
    _searchTableView.estimatedRowHeight = 190;//the estimatedRowHeight but if is more this autoincremented with autolayout

    [_searchTableView setNeedsLayout];
    [_searchTableView layoutIfNeeded];
}
-(void)reloadData2{
    [self refreshTable];
}

- (void)refreshTable {
    //TODO: refresh your data
      [self resignFirstResponder];
    [self->_searchTableView.refreshControl endRefreshing];
    [self.searchTableView reloadData];
}


- (IBAction)tapSearchBtn:(id)sender
{
    NSLog(@"2: %@",_txtSearch.text);
    if (![_txtSearch.text isEqual: @""])
    {
    searchKey = [_txtSearch.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    searchKey = [searchKey stringByReplacingOccurrencesOfString:@" "
                                   withString:@"+"];
    [self praseSearch];
    [self.searchTableView setNeedsLayout];
    [self.searchTableView layoutIfNeeded];
    [self->_searchTableView.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
        
        [_txtSearch resignFirstResponder];
//    [_searchTableView setHidden:NO];
      
    }
}

-(void)praseSearch
{
    //1.創建會話管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //https://itunes.apple.com/search?term=jack+johnson&entity=movie
    //
    NSMutableArray *paramDict = [@{
                                   @"term":searchKey
                                   ,@"entity":@"movie"
//                                   ,@"attribute":@"movieTerm"
                                   } mutableCopy];

    NSMutableArray *paramDict2 = [@{
                                   @"term":searchKey
                                   } mutableCopy];
//movie
    [manager GET:@"https://itunes.apple.com/search" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
        NSLog(@"%@---%@",[responseObject class],responseObject);
            self->movieRow = responseObject[@"results"];
            [self refreshTable];
            self->moiveResultCount =  [responseObject[@"resultCount"] longLongValue];
            if (self->moiveResultCount <= 0)
            {
                NSLog(@"*movie not found!");
                [self->_searchTableView setHidden:YES];
            }
            else
            {
                [self->_searchTableView setHidden:NO];
            }
         }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"movie请求失败--%@",error);
    }];
    
//music
    [manager GET:@"https://itunes.apple.com/search" parameters:paramDict2 progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject isKindOfClass:[NSDictionary class]])
        {
            NSLog(@"%@---%@",[responseObject class],responseObject);
            self->musicRow = responseObject[@"results"];
            [self refreshTable];
            self->musicResultCount =  [responseObject[@"resultCount"] longLongValue];
            if (self->musicResultCount <= 0)
            {
                NSLog(@"*movie not found!");
                [self->_searchTableView setHidden:YES];
            }
            else
            {
                [self->_searchTableView setHidden:NO];
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"music请求失败--%@",error);
    }];

}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return movieRow.count;
    else if (section == 1)
        return musicRow.count;
    else
        return 0;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Moive";
    else if (section == 1)
        return @"Music";
    else
        return @"";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchTableViewCell *cell = [SearchTableViewCell new];
    if (indexPath.section == 0)
   {
            if (self->moiveResultCount > 0)
            {
               cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
               NSString *url = movieRow[indexPath.row][@"artworkUrl60"];
//               NSLog(@"url: %@",url);
               [cell.imgPicture sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"Pichoder"]];
                cell.lblTrackName.text = movieRow[indexPath.row][@"trackName"];
                cell.lblAristName.text = movieRow[indexPath.row][@"artistName"];
                cell.lblCollectionName.text = movieRow[indexPath.row][@"trackCensoredName"];
                cell.artworkUrl60 = url;
                long h,m,s,tt;
                NSString *fmtString;
                tt = [movieRow[indexPath.row][@"trackTimeMillis"] longValue] /1000;
                h = tt /3600;
                m = tt %3600 /60;
                s = tt % 60;
                fmtString = [NSString stringWithFormat:@"%ldh: %ldm :%lds",h,m,s];
               cell.lblLength.text = fmtString;
               cell.lblLongDescription.text = movieRow[indexPath.row][@"longDescription"];
               cell.parterTableView =  _searchTableView;
            
                
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
                [cell.btnReadMore setHidden:NO];
    
            }
            else{
                    NSLog(@"-moiveResultCount <= 0");
            }
         [cell reloadInputViews];
     }else{
          if (self->musicResultCount > 0)
         {
             cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell" forIndexPath:indexPath];
             NSString *url = musicRow[indexPath.row][@"artworkUrl60"];
             NSLog(@"url: %@",url);
             cell.artworkUrl60 = url;
             [cell.imgPicture sd_setImageWithURL:[NSURL URLWithString:url]
                                placeholderImage:[UIImage imageNamed:@"Pichoder"]];
             cell.lblTrackName.text = musicRow[indexPath.row][@"trackName"];
             cell.lblAristName.text = musicRow[indexPath.row][@"artistName"];
             cell.lblCollectionName.text = musicRow[indexPath.row][@"collectionName"];
        
             long h,m,s,tt;
             NSString *fmtString;
             tt = [musicRow[indexPath.row][@"trackTimeMillis"] longValue] /1000;
             h = tt /3600;
             m = tt %3600 /60;
             s = tt % 60;
             fmtString = [NSString stringWithFormat:@"%ldh: %ldm :%lds",h,m,s];
             cell.lblLength.text = fmtString;
             //-- favroite
             
             cell.kind = musicRow[indexPath.row][@"kind"];
             cell.trackViewUrl = musicRow[indexPath.row][@"trackViewUrl"];
             long lTrackId= [musicRow[indexPath.row][@"trackId"] longValue];
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
             [cell.lblLongDescription setHidden:YES];
             [cell.btnReadMore setHidden:YES];
         }
         else{
             NSLog(@"-musicResultCount <= 0");
         }
       
     }
    

      return cell;
}

@end
