![](Assets/banner.jpg)

I recommend to read about [SkeletonView](https://github.com/Juanpe/SkeletonView) to understand on how it works before you will use this sample project.  
  
SkeletonableTableView is the another way to implement UITableView with skeletonable effect and without any delegate or datasource protocols. It was written as a wrapper over [SkeletonView](https://github.com/Juanpe/SkeletonView) by [Juanpe](https://github.com/Juanpe). You can do any customizations you want and use this project as a sample  
  
##  🕹 Installation  
  
Firstly, you should install [SkeletonView](https://github.com/Juanpe/SkeletonView) to your project. There are several ways on how to [install](https://github.com/Juanpe/SkeletonView#-installation) it.  
After installation, just drag and drop the [Sources](https://github.com/zainoldin/SkeletonableTableView/tree/develop/SkeletonableTableView) folder to your project and customize it if you want to.  
  
## 🧐 How to use?  
**1.** Import SkeletonView in proper place.  
```swift  
import SkeletonView  
```  
**2.** Now, you can make your UITableView skeletonable in two ways.  
Just use **SkeletonableTableView**:  
```swift  
lazy var tableView = SkeletonableTableView()  
// or by Interface builder  
@IBOutlet weak var tableView: SkeletonableTableView!  
```  
Create your own class and inherit from **SkeletonableTableView**:  
```swift  
class CustomTableView: SkeletonableTableView {}  
```  
**3.** Create **UITableViewCells**, inherit from **SkeletonableTableViewCell** and register to your tableView.  
```swift  
class CustomCell: SkeletonableTableViewCell {}  
```  
**4.** If you have sections/footers you should create class, inherit from **SkeletonableHeaderFooterView** and register it too.  
```swift  
class CustomHeaderView: SkeletonableHeaderFooterView {}  
```  
> **Important**: add all UIViews to contentView, not to root view. Otherwise, only rootView will be skeletoned and wouldn't work as expected. I suggest to implement your custom UITableViewHeaderFooterView programmatically as I couldn't find another way to add UIViews to contentView by Interface Builder  
  
  
**3.** You have 4 choices to show the **skeleton** on tableView (but you can create your own and improve it):  
```swift  
(1) tableView.showSolidSkeleton()               // Solid without animation  
(2) tableView.showSolidSkeletonAnimating()      // Solid animated  
(3) tableView.showGradientedSkeleton()          // Gradient  
(4) tableView.showGradientedSkeletonAnimating() // Gradient animated  
``` 
**Preview** from [SkeletonView](https://github.com/Juanpe/SkeletonView)

<table>
<tr>
<td width="25%">
<center>Solid</center>
</td>
<td width="25%">
<center>Solid Animated</center>
</td>
<td width="25%">
<center>Gradient</center>
</td>
<td width="25%">
<center>Gradient Animated</center>
</td>
</tr>
<tr>
<td width="25%">
<img src="Assets/solid.png"></img>
</td>
<td width="25%">
<img src="Assets/solid_animated.gif"></img>
</td>
<td width="25%">
<img src="Assets/gradient.png"></img>
</td>
<td width="25%">
<img src="Assets/gradient_animated.gif"></img>
</td>
</tr>
</table>
 
## Additional configurations  
### SkeletonableTableView  
You can set one color for all the cells and headerFooterViews by changing the value of **skeletonTintColor**:  
```swift  
tableView.skeletonTintColor = UIColor.gray  
```  
You can change the corner radius of all skeletoned views (defaults to 4.0):  
```swift  
tableView.cornerRadius = 8.0  
```  
### SkeletonableTableViewCell  
SkeletonableTableViewCell marks only subviews of contentView as skeletonable, but you can tweak the marking behavior in your own way. You should just override function **setupSkeletonableViews()** in your cell and change skeletonable configurations for specific views. You can see it in [Circled Cell (from example)](https://github.com/zainoldin/SkeletonableTableView/blob/develop/SkeletonableTableView/Example/SkeletonableViewController/View/CircledCell/CircledCell.swift) in details. In my case, I didn't want to skeletone some views (*blackLineView*), also I wished to make subviews of containerView skeletonable (not only containerView).  
```swift  
// from example  
override func setupSkeletonableViews() {  
    super.setupSkeletonableViews()  
    let views: [UIView] = [[conainerView], conainerView.subviews, stackView.arrangedSubviews].flatMap { $0 }  
    views.forEach { $0.isSkeletonable = true }  
    blackLineView.isSkeletonable = false  
}  
```  
There can be some cases when we need to set different skeleton color or appearance configuration for specific cells. In that case, you just override function which is used to show skeleton in your cell. Example from [ProfileCell](https://github.com/zainoldin/SkeletonableTableView/blob/feature/readme-configuration/SkeletonableTableView/Example/SkeletonableViewController/View/ProfileCell/ProfileCell.swift):  
```swift  
// Or override any function from 4  
override func showSolidSkeletonAnimating(color: UIColor = SkeletonAppearance.default.tintColor, animation: SkeletonLayerAnimation? = nil, transition: SkeletonTransitionStyle = .none) {  
    // skeleton color of specific cell was changed to `UIColor.black`  
    super.showSolidSkeletonAnimating(color: .black, animation: animation, transition: transition)  
}  
```
