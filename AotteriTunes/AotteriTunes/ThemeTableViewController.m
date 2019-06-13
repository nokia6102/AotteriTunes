
#import "ThemeTableViewController.h"
#import "Settings.h"

@interface ThemeTableViewController ()
{
    NSIndexPath *lastSelected;
}
@end

@implementation ThemeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.

}

#pragma mark - Table view data source

- (void)notificationThemeColorChanged:(NSNotification *)notification {
    
    UIColor *changedColor = notification.object;
    [self.view setBackgroundColor:changedColor];
}



// UITableView Delegate Method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( indexPath.row == 0)
    {
         [Settings sharedSettings].themeColor = UIColor.brownColor;
        [self.view setBackgroundColor:[Settings sharedSettings].themeColor];
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                 initWithTitle:@"Dark" message:@"深色主題設定完成" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"dark" forKey:@"themeset"];
        [defaults synchronize];
        // Display Alert Message
        [messageAlert show];
       
        
    }
    else
    {
        [Settings sharedSettings].themeColor = UIColor.greenColor;
        NSLog(@"color: %@", [Settings sharedSettings].themeColor );
        [self.view setBackgroundColor:[Settings sharedSettings].themeColor];

        
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Light" message:@"淺色主題設定完成" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
     
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:@"light" forKey:@"themeset"];
        [defaults synchronize];
        // Display Alert Message
        [messageAlert show];
        

    }
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
