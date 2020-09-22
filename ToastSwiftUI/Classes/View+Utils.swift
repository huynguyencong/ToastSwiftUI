//
//  View+Utils.swift
//  ToastSwiftUI
//
//  Created by Huy Nguyen on 9/22/20.
//

import Foundation
import SwiftUI

extension View {
    func `ifElse`<V: View, T: View>(_ condition: Bool, _ then: (Self) -> V, `else`: ((Self) -> T)) -> AnyView {
        if condition {
            return AnyView(then(self))
        }
        else {
            return AnyView(`else`(self))
        }
    }
    
    func `if`<V: View>(_ condition: Bool, _ then: (Self) -> V) -> AnyView {
        if condition {
            return AnyView(then(self))
        }
        else {
            return AnyView(self)
        }
    }
}
