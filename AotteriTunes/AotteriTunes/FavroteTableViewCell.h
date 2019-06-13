
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FavroteTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTrackName;
@property (weak, nonatomic) IBOutlet UILabel *lblAristName;
@property (weak, nonatomic) IBOutlet UILabel *lblCollectionName;
@property (weak, nonatomic) IBOutlet UILabel *lblLength;
@property (weak, nonatomic) IBOutlet UILabel *lblLongDescription;
@property (weak, nonatomic) IBOutlet UIImageView *imgPicture;
@property (weak, nonatomic) IBOutlet UIButton *btnReadMore;
@property (weak, nonatomic) IBOutlet UIButton *btnFavorte;

@property (assign, nonatomic) long trackId;
@property (weak, nonatomic) NSString *kind;
@property (weak, nonatomic) NSString *trackViewUrl;
@property (weak, nonatomic) NSString *artworkUrl60;
//@property (weak, nonatomic) NSString *TrackName;
//@property (weak, nonatomic) NSString *AristName;
//@property (weak, nonatomic) NSString *CollectionName;
@property (weak, nonatomic) NSString *Length;


@end

NS_ASSUME_NONNULL_END
