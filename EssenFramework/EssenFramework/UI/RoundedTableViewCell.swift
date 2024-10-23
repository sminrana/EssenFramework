
import Foundation
import UIKit

public class RoundedTableViewCell: UITableViewCell {
    @IBOutlet weak var containerView:UIView?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.containerView?.layer.cornerRadius = 8;
        self.containerView?.layer.masksToBounds = true;
    }
}
