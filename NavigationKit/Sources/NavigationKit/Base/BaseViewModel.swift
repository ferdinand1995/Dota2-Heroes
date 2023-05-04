//
//  ParentViewModel.swift
//  Diabetic Educator
//
//  Created by Ferdinand on 09/09/21.
//

import Foundation

open class BaseViewModel {

    public init() { }

    public var isLoadingStated: (_ loading: Bool) -> Void = { _ in }
    public var onErrorBlock: ((_ error: (code: Int?, msg: String)) -> Void)?
    public var didTapBack: (() -> Void)?
    public var didSelect: (() -> Void)?
}
