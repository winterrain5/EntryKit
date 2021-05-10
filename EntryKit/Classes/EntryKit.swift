//
//  CKEntryKit.swift
//  ClassRoomKit
//
//  Created by VICTOR03 on 2021/5/9.
//

private let kScreenHeight:CGFloat = UIScreen.main.bounds.size.height

enum EntryStyle {
    case sheet
    case alert
}

class EntryKit:UIView {
    private static let animateDuration:TimeInterval = 0.5
    private static let animateDamping:CGFloat = 0.9
    private static let animateVelocity:CGFloat = 2
    private static var style:EntryStyle = .alert
    private static var childView: UIView!
    static func display(view:UIView,
                        size:CGSize,
                        style:EntryStyle,
                        backgroundColor:UIColor = UIColor.black.withAlphaComponent(0.3)) {
        let superView = UIApplication.shared.keyWindow
        if superView?.subviews.contains(view) ?? false {
            return
        }
        EntryKit.style = style
        EntryKit.childView = view
        
        let container = EntryKit()
        container.frame = UIScreen.main.bounds
        container.backgroundColor = backgroundColor
        superView?.addSubview(container)
        
        container.addSubview(view)
        view.frame.size = size
        
        if style == .alert {
            alertDisplay(view: view, size: size)
        }else {
            sheetDisplay(view: view, size: size)
        }
    }
    
    static func dismiss() {
        let superView = UIApplication.shared.keyWindow?.subviews.last
        if !(superView?.isKind(of: EntryKit.self) ?? false) {
            return
        }
        let subView = EntryKit.childView
        if EntryKit.style == .alert {
            UIView.animate(withDuration: EntryKit.animateDuration,
                           delay: 0.1,
                           usingSpringWithDamping: EntryKit.animateDamping,
                           initialSpringVelocity: EntryKit.animateVelocity,
                           options: .curveEaseOut) {
                superView?.backgroundColor = .clear
                subView?.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
                subView?.alpha = 0
            } completion: { (flag) in
                superView?.removeFromSuperview()
                subView?.removeFromSuperview()
            }
        }else {
            UIView.animate(withDuration: EntryKit.animateDuration,
                           delay: 0.1,
                           usingSpringWithDamping: EntryKit.animateDamping,
                           initialSpringVelocity: EntryKit.animateVelocity,
                           options: .curveEaseOut) {
                superView?.backgroundColor = .clear
                subView?.frame.origin = CGPoint(x: 0, y: kScreenHeight)
            } completion: { (flag) in
                superView?.removeFromSuperview()
                subView?.removeFromSuperview()
            }
        }
    }
    
    private static func alertDisplay(view:UIView,size:CGSize) {
        view.center = view.superview?.center ?? .zero
        view.transform = CGAffineTransform.init(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: EntryKit.animateDuration,
                       delay: 0,
                       usingSpringWithDamping: EntryKit.animateDamping,
                       initialSpringVelocity: EntryKit.animateVelocity,
                       options: .curveEaseIn,
                       animations: {
                view.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    private static func sheetDisplay(view:UIView,size:CGSize) {
        view.frame.origin = CGPoint(x: 0, y: kScreenHeight)
        UIView.animate(withDuration: EntryKit.animateDuration,
                       delay: 0,
                       usingSpringWithDamping: EntryKit.animateDamping,
                       initialSpringVelocity: EntryKit.animateVelocity,
                       options: .curveEaseIn,
                       animations: {
            view.frame.origin = CGPoint(x: 0, y: kScreenHeight - size.height)
        }, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        EntryKit.dismiss()
    }
    
}
