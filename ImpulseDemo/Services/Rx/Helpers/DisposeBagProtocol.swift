//
//  DisposeBagProtocol.swift
//  ImpulseDemo
//
//  Created by Daniel Dyachok on 21.08.2022.
//

import Foundation
import RxSwift

protocol DisposeBagProtocol: AnyObject {
    var disposeBag: DisposeBag { get set }
}

private struct AssociatedKeys {
    static var disposeBag = "rx_disposeBag"
}

extension DisposeBagProtocol {
    var disposeBag: DisposeBag {
        get {
            if let disposeBag = objc_getAssociatedObject(self, &AssociatedKeys.disposeBag) as? DisposeBag {
                return disposeBag
            }
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, DisposeBag(), .OBJC_ASSOCIATION_RETAIN)
            return self.disposeBag
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.disposeBag, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
