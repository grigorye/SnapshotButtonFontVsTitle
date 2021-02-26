import UIKit

@objc
class SampleNibViewWithButton: UIView {
    
    init(setButton: @escaping (UIButton) -> Void, button: UIButton? = nil) {
        self.setButton = setButton
        self.button = button
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var setButton: (_ button: UIButton) -> Void
    
    @IBOutlet private var button: UIButton! {
        willSet {
            guard let button = newValue else {
                return
            }
            setButton(button)
        }
    }
}
