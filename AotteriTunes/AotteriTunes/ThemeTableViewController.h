
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ThemeTableViewController : UITableViewController
@property (strong, nonatomic) IBOutletCollection(UITableViewCell) NSArray *themeStaticCell;

@end

NS_ASSUME_NONNULL_END
