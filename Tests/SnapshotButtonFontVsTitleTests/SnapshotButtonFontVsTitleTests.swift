@testable import SnapshotButtonFontVsTitle
import SnapshotTesting
import XCTest
import UIKit

class SnapshotButtonFontVsTitleTests: XCTestCase {
    
    private let record = false
    
    func test() {
        for titleVsFontSetOrder in TitleVsFontSetOrder.allCases {
            for buttonKind in ButtonKind.allCases {
                for nibVsCode in NibVsCode.allCases {
                    test(config: .init(nibVsCode: nibVsCode, buttonKind: buttonKind, titleVsFontSetOrder: titleVsFontSetOrder))
                }
            }
        }
    }
   
    private func test(config: Config, testName: String = #function) {
        let name = [
            config.nibVsCode.rawValue,
            config.buttonKind.rawValue,
            config.titleVsFontSetOrder.rawValue,
        ].joined(separator: "-")
        
        let controller = UIViewController()
        controller.view = view(config: config)
        assertSnapshot(matching: controller, as: .image, named: name, record: record, testName: testName)
    }
    
    private func view(config: Config) -> UIView {
        
        let view: UIView
        let contentView: UIView
        
        func setButton(_ button: UIButton) {
            switch config.titleVsFontSetOrder {
            case .titleBeforeFont:
                button.setTitle("XXX", for: UIControl.State())
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            case .titleAfterFont:
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                button.setTitle("XXX", for: UIControl.State())
            }
            button.backgroundColor = .systemOrange
        }
        
        switch config.nibVsCode {
        case .code:
            let buttonType: UIButton.ButtonType = {
                switch config.buttonKind {
                case .system:
                    return .system
                case .custom:
                    return .custom
                }
            }()
            
            let button = UIButton(type: buttonType)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            setButton(button)
            
            contentView = UIView()
            contentView.backgroundColor = .systemGreen

            contentView.addSubview(button)
            [
                button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            ].forEach { $0.isActive = true }
            
            view = UIView()

        case .nib:
            let buttonKindInNibName: String = {
                switch config.buttonKind {
                case .system:
                    return "System"
                case .custom:
                    return "Custom"
                }
            }()
            let nib = UINib(nibName: "SampleNibWith\(buttonKindInNibName)Button", bundle: .module)
            
            view = SampleNibViewWithButton(setButton: setButton)
            view.translatesAutoresizingMaskIntoConstraints = false
            
            contentView = nib.instantiate(withOwner: view, options: nil).first as! UIView
        }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(contentView)
        
        [
            contentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            contentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ].forEach { $0.isActive = true }
        
        view.frame.size = CGSize(width: 100, height: 100)
        return view
    }
}

struct Config {
    var nibVsCode: NibVsCode
    var buttonKind: ButtonKind
    var titleVsFontSetOrder: TitleVsFontSetOrder
}

enum TitleVsFontSetOrder: String, CaseIterable {
    case titleBeforeFont
    case titleAfterFont
}

enum ButtonKind: String, CaseIterable {
    case custom
    case system
}

enum NibVsCode: String, CaseIterable {
    case nib
    case code
}
