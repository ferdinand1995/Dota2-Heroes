//
//  ParentViewController.swift
//  MySiloam
//
//  Created by DSS-Titus on 10/08/21.
//  Copyright © 2019 siloamhospital. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    var isShowingAlert = false
    var isShowingMsg = false

    var bgCustomView = UIView()
    var label: UILabel = UILabel()
    var periodType: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
    }

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    init(nibName: String) {
        super.init(nibName: nibName, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Navigation
    @IBAction func backButtonTapped(_ sender: Any) {
        let _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func dismissTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    //MARK: - Loading
    func showLoading(_ view: UIView, views: [UIView] = [UIView](), _ text: String = "") {
        self.view.hideAllToasts()
        self.view.makeToastActivity(.center)
        _ = views.map ({ $0.isUserInteractionEnabled = false })
    }

    func hideLoading(_ view: UIView, views: [UIView] = [UIView]()) {
        _ = views.map ({ $0.isUserInteractionEnabled = true })
    }
    //MARK: - Loading [END]



    //MARK: - Keyboard
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ParentViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    //MARK: - Keyboard [END]

    @objc func customErrorButtonTapped() {
        bgCustomView.removeFromSuperview()
    }

    func setButtonAttributedTextWithUnderline(button: UIButton, text: String) {
        let attribute: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.MAIN_BLUE_COLOR,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont(name: "Nunito-Bold", size: 14.0)!
        ]
        let attributedString = NSAttributedString(string: text, attributes: attribute)
        button.setAttributedTitle(attributedString, for: .normal)
    }

    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    func getOffset(currentDataCount: Int, totalData: Int) -> Int {
        if currentDataCount <= totalData {
            return currentDataCount % 10 == 0 ? (currentDataCount / 10) : -1
        }
        return -1
    }

    func generateQRCode(string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }

    func callNumber(phone: String) {
        if let url = URL(string: "telprompt://\(phone)") {
            let application = UIApplication.shared
            guard application.canOpenURL(url) else {
                return
            }
            application.open(url, options: [:], completionHandler: nil)
        }
    }
}

//MARK: Error/Message
extension ParentViewController {

    func showBottomSheetAlert(view: UIView, msg: String) {
        let alertSheetView = AlertSheetView(frame: view.bounds)
        alertSheetView.messageLabel.text = msg
        alertSheetView.subscribeSheetAction = {
            self.view.removeSubviewAnimate(customView: alertSheetView)
        }

        self.view.addSubviewAnimate(customView: alertSheetView) { _ in
            alertSheetView.animateOpeningView()
        }

        delay(3.0) {
            alertSheetView.dismissTapped(self)
        }
    }

}

//MARK: Labels
extension ParentViewController {

    func setLabelNoData(tableView: UITableView) {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: tableView.contentSize.height))
        label.text = "no_data".localized()
        label.font = UIFont(name: "Nunito-Bold", size: 13.0)!
        label.textColor = .DARK_GRAY_COLOR
        label.textAlignment = .center
        label.sizeToFit()
        label.isHidden = false
        tableView.backgroundView = label
        tableView.separatorStyle = .none
    }

    func hideLabelNoData() {
        /// hide label used to show table/collection view has no data
        label.isHidden = true
    }

    func attributedText(withString string: String, boldString: String, font: UIFont) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: string,
            attributes: [NSAttributedString.Key.font: font])
        let boldFontAttribute: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: font.pointSize)]
        let range = (string as NSString).range(of: boldString)
        attributedString.addAttributes(boldFontAttribute, range: range)
        return attributedString
    }
}

