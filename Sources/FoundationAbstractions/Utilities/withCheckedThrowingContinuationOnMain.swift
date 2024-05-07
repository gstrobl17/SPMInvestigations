import UIKit

// Nifty piece of code from https://forums.swift.org/t/xcode-14-1-withcheckedcontinuations-body-will-run-on-background-thread-in-case-of-starting-from-main-actor/60953/3

@MainActor
public func withCheckedThrowingContinuationOnMain<T>(function: String = #function, _ body: @escaping @MainActor (CheckedContinuation<T, Error>) -> Void) async throws -> T {
    try await withCheckedThrowingContinuation { continuation in
        Task { @MainActor in
            body(continuation)
        }
    }
}
