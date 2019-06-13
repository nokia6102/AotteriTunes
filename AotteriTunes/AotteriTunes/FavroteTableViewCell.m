
#import "Settings.h"
#import "FavroteTableViewCell.h"

@implementation FavroteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)tapGoUrl:(UIButton *)sender {
    NSLog(@"*>go url:%@",_trackViewUrl);
    [[Settings sharedSettings] setUrlString:_trackViewUrl];
}

- (IBAction)tapRemoveFavorite:(UIButton *)sender
{
    NSLog(@"Press tapFavorite");
    
    NSString *favIdKey = [[NSNumber numberWithLong:_trackId] stringValue];
    NSLog(@"*favIdKey: %@",favIdKey);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favoritesLoaded = [defaults objectForKey:@"favorites"];
    
    NSString *favIdSaved= [defaults objectForKey: favIdKey ];
    NSInteger favCount = [defaults integerForKey: @"favCount"];
    
    NSLog(@"%@",favIdSaved);
    
    
    if (favIdSaved == NULL)     //目前為未收藏
    {
        favCount++;
        [defaults setInteger: favCount forKey:@"favCount"];
        [defaults setInteger: _trackId forKey: favIdKey];
        [defaults synchronize];
        
        //-- Save Favorite Data
        NSLog(@"*-lblTrackName :%@",_lblTrackName.text);
        NSDictionary *fav = [NSDictionary dictionaryWithObjectsAndKeys:
                             _kind,@"kind",
                             [NSNumber numberWithLong:_trackId], @"trackId",
                             _trackViewUrl, @"trackViewUrl",
                             _lblTrackName , @"trckName",
                             _lblAristName.text, @"aristName",
                             _lblCollectionName.text, @"collectionName",
                             _lblLength.text, @"length",
                             _lblLongDescription.text, @"longDescription",
                             _artworkUrl60,@"artworkUrl60",
                             nil];
        
        NSMutableArray *favorites = [NSMutableArray array];
        
        NSLog(@"->favrite array %@",favorites);
        
        if (favoritesLoaded) {
            favorites = [[NSMutableArray alloc] initWithArray:favoritesLoaded];
        } else {
            favorites = [[NSMutableArray alloc] init];
        }
        
        [favorites addObject:fav];
        
        
        [defaults setObject:favorites forKey:@"favorites"];
        [defaults synchronize];
        
        //--
        
        NSLog(@"*-favorites.count: %ld",favorites.count);
        //         [defaults setObject: @(favorites.count) forKey:favIdKey]; xxx
        //         [defaults synchronize];
        
        
        [_btnFavorte setTitle:@"取消收藏" forState:UIControlStateNormal];
        NSLog(@"*-Add favIDed");
        
    }else{//Have
        
        
        favCount--;
        [defaults setInteger:favCount forKey:@"favCount"];
        
        //         NSDictionary *favIdSaved= [defaults objectForKey: @"favorites" ];
        NSMutableArray *removedData =  [NSMutableArray array];
        //--remove data
        //        NSDictionary *fav = [NSDictionary dictionaryWithObjectsAndKeys:
        //                             _kind,@"kind",
        //                             [NSNumber numberWithLong:_trackId], @"trackId",
        //                             _trackViewUrl, @"trackViewUrl",
        //                             _lblTrackName.text, @"TrckName",
        //                             _lblAristName.text, @"AristName",
        //                             _lblCollectionName.text, @"CollectionName",
        //                             _lblLength.text, @"Length",
        //                             _lblLongDescription.text, @"LongDescription",
        //                             nil];
        //
        NSMutableArray *favorites = [NSMutableArray array];
        //
        //        NSLog(@"->favrite array %@",favorites);
        //
        if (favoritesLoaded) {
            favorites = [[NSMutableArray alloc] initWithArray:favoritesLoaded];
        } else {
            favorites = [[NSMutableArray alloc] init];
        }
        
        //        int delItemId = [[defaults objectForKey:favIdKey] intValue];
        int delItemId = [[defaults objectForKey:favIdKey] intValue];
        
        // After your loop
        removedData = [[NSMutableArray alloc] init];
        [removedData removeAllObjects];
        
        long count = favorites.count;
        
        
        
        for (int i=0 ;i<count ;i++)
        {
            NSLog(@"[%i] %@",i,favorites[i][@"trackId"]);
            //        NSLog(@"indexof: %lu", [favorites indexOfObject:favIdKey]);
            NSLog(@"remove id: %i",[favorites[i][@"trackId"]intValue]);
            if ([favorites[i][@"trackId"]intValue] != delItemId)
            //            if ((delItem-1) != i)
            {
                [removedData addObject: favorites[i] ];
            }
            else
            {
                NSLog(@"*-Remove this---> %@",favorites[i]);
            }
        }
        
        
        NSLog(@"removed than favorites: %@ count:%ld",removedData ,removedData.count);
        
        
        [defaults removeObjectForKey:@"favorites"];
        [defaults synchronize];
        
        [defaults setObject:removedData forKey:@"favorites"];
        [defaults synchronize];
        
        //--
        [defaults removeObjectForKey:favIdKey];
        [defaults synchronize];
        [_btnFavorte setTitle:@"收藏" forState:UIControlStateNormal];
        NSLog(@"*-remove favIDed");
    }
    
    favoritesLoaded = [defaults objectForKey:@"favorites"];
    NSLog(@"*- than real favcount:%ld",(long) favoritesLoaded.count );
    //    NSLog(@"*- than favcount:%ld",(long)[defaults integerForKey: @"favCount"] );
    [_btnFavorte setTitle:@"已移除" forState:UIControlStateNormal];
    [_btnFavorte setEnabled:NO];
     
    
}

@end
