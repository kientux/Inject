import Foundation
import SwiftUI

#if DEBUG
@available(iOS 13.0, tvOS 13.0, *)
public extension SwiftUI.View {
    func enableInjection() -> some SwiftUI.View {
        _ = Inject.load
        
        // Use AnyView in case the underlying view structure changes during injection.
        // This is only in effect in debug builds.
        return AnyView(self)
    }

    func onInjection(callback: @escaping (Self) -> Void) -> some SwiftUI.View {
        onReceive(Inject.combineObserver.objectWillChange, perform: {
            callback(self)
        })
        .enableInjection()
    }
}

#else
public extension SwiftUI.View {
    @inlinable @inline(__always)
    func enableInjection() -> Self { self }

    @inlinable @inline(__always)
    func onInjection(callback: @escaping (Self) -> Void) -> some SwiftUI.View {
        self
    }
}
#endif
