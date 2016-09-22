#import "MainTableViewController.h"
#import "CalculatorViewController.h"
#import "ReversedStringViewController.h"
#import "SillySnakeViewController.h"

@interface MainTableViewController (){
    NSArray *menuList;
}
@end

@implementation MainTableViewController

- (void)viewDidLoad {
    menuList = @[@"計算機-Calculator",@"字串反轉-Reversed String",@"貪食蛇-Silly Snake"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [menuList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (!cell)
        cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = menuList[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *Calculator = NSStringFromSelector(@selector(showCalculatorViewController));
    NSString *ReversedString = NSStringFromSelector(@selector(showReversedStringViewController));
    NSString *SillySnake = NSStringFromSelector(@selector(showSillySnakeViewController));
    NSArray *array = @[Calculator,ReversedString,SillySnake];
    SuppressPerformSelectorLeakWarning(
        [self performSelector:NSSelectorFromString(array[indexPath.row])];
    );
}

- (void)showCalculatorViewController {
    CalculatorViewController *myCalculatorViewController = [[CalculatorViewController alloc]initWithNibName:@"CalculatorViewController" bundle:nil];
    myCalculatorViewController.navigationItem.title = menuList[0];
    [self.navigationController pushViewController:myCalculatorViewController animated:YES];
}

- (void)showReversedStringViewController {
    ReversedStringViewController *myReversedStringViewController = [[ReversedStringViewController alloc]initWithNibName:@"ReversedStringViewController" bundle:nil];
    myReversedStringViewController.navigationItem.title = menuList[1];
    [self.navigationController pushViewController:myReversedStringViewController animated:YES];
}

- (void)showSillySnakeViewController {
    SillySnakeViewController *mySillySnakeViewController = [[SillySnakeViewController alloc]initWithNibName:@"SillySnakeViewController" bundle:nil];
    [self presentViewController:mySillySnakeViewController animated:YES completion:nil];
}

@end
