//
//  UITextField+Utility.swift
//  Extensions for textfields
//
//  Created by Suman Sigdel and Niv Ben-porath on 4/19/20.
//  Copyright © 2020 Suman Sigdel, Niv Ben-porath. All rights reserved.
//

import UIKit

extension UITextField {

    func setBottomBorder(color: UIColor = UIColor.white, shadowColor: UIColor = UIColor.gray) {
        self.borderStyle = .none
        self.layer.backgroundColor = color.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }

    func addRoundedCorner(cornerRadius: CGFloat, borderWidth: CGFloat = 1.0, color: UIColor = .gray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = color.cgColor
    }
}

//
//  FloatingTextField.swift
//  AnimatedTextField
//
//  Created by Alexey Zhulikov on 22.10.2019.
//  Copyright © 2019 Alexey Zhulikov. All rights reserved.
//

private extension TimeInterval {
    static let animation250ms: TimeInterval = 0.25
}

private enum Constants {
    static let offset: CGFloat = 8
    static let placeholderSize: CGFloat = 14
}

final class FloatingTextField: UITextField {

    // MARK: - Subviews
    private var border = UIView()
    private var label = UILabel()

    // MARK: - Private Properties
    private var scale: CGFloat {
        Constants.placeholderSize / fontSize
    }

    private var fontSize: CGFloat {
        font?.pointSize ?? 0
    }

    private var labelHeight: CGFloat {
        ceil(font?.withSize(Constants.placeholderSize).lineHeight ?? 0)
    }

    private var textHeight: CGFloat {
        ceil(font?.lineHeight ?? 0)
    }

    private var isEmpty: Bool {
        text?.isEmpty ?? true
    }

    private var textInsets: UIEdgeInsets {
        UIEdgeInsets(top: Constants.offset + labelHeight, left: 0, bottom: Constants.offset, right: 0)
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    // MARK: - UITextField
    override var intrinsicContentSize: CGSize {
        return CGSize(width: bounds.width, height: textInsets.top + textHeight + textInsets.bottom)
    }

    override var placeholder: String? {
        didSet {
            label.text = placeholder
        }
    }

    var borderColor: UIColor? = .gray {
        didSet {
            border.backgroundColor = borderColor
        }
    }
    
    var placeHolderColor: UIColor? = .gray {
        didSet {
            label.textColor = placeHolderColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        border.frame = CGRect(x: 0, y: bounds.height - 1, width: bounds.width, height: 1)
        updateLabel(animated: false)
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return .zero
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard !isFirstResponder else {
            return
        }

        label.transform = .identity
        label.frame = bounds.inset(by: textInsets)
    }

    // MARK: - Private Methods
    private func setupUI() {
        borderStyle = .none

        border.backgroundColor = borderColor
        border.isUserInteractionEnabled = false
        addSubview(border)

        label.textColor = placeHolderColor
        label.font = font
        label.text = placeholder
        label.isUserInteractionEnabled = false
        addSubview(label)

        addTarget(self, action: #selector(handleEditing), for: .allEditingEvents)
    }

    @objc private func handleEditing() {
        updateLabel()
        updateBorder()
    }

    private func updateBorder() {
        let borderColor = isFirstResponder ? tintColor : borderColor
        UIView.animate(withDuration: .animation250ms) {
            self.border.backgroundColor = borderColor
        }
    }

    private func updateLabel(animated: Bool = true) {
        let isActive = isFirstResponder || !isEmpty

        let offsetX = -label.bounds.width * (1 - scale) / 2
        let offsetY = -label.bounds.height * (1 - scale) / 2

        let transform = CGAffineTransform(translationX: offsetX, y: offsetY - labelHeight - Constants.offset)
            .scaledBy(x: scale, y: scale)

        guard animated else {
            label.transform = isActive ? transform : .identity
            return
        }

        UIView.animate(withDuration: .animation250ms) {
            self.label.transform = isActive ? transform : .identity
        }
    }
}
