
#import <UIKit/UIKit.h>

@interface FavroteViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *searchTableView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *itemSegmentControl;

@end

