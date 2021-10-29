//
//  ParentViewModel.swift
//  Diabetic Educator
//
//  Created by Ferdinand on 09/09/21.
//

import Foundation

class Observable<T> {

    public var value: T {
        didSet {
            listener?(value)
        }
    }

    private var listener: ((T) -> Void)?

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listener = closure
    }
}

open class ParentViewModel {

    public var isLoadingStated: (_ loading: Bool) -> Void = { _ in }
    public var onErrorBlock: ((_ error: (code: Int?, msg: String)) -> Void)?
}
