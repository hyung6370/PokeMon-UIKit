/*
 * This file is part of the SDWebImage package.
 * (c) DreamPiggy <lizhuoli1126@126.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

import SwiftUI
import Combine
import SDWebImage

/// A Image observable object for handle image load process. This drive the Source of Truth for image loading status.
/// You can use `@ObservedObject` to associate each instance of manager to your View type, which update your view's body from SwiftUI framework when image was loaded.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public final class ImageManager : ObservableObject {
    /// loaded image, note when progressive loading, this will published multiple times with different partial image
    public var image: PlatformImage? {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    /// loaded image data, may be nil if hit from memory cache. This will only published once even on incremental image loading
    public var imageData: Data? {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    /// loaded image cache type, .none means from network
    public var cacheType: SDImageCacheType = .none {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    /// loading error, you can grab the error code and reason listed in `SDWebImageErrorDomain`, to provide a user interface about the error reason
    public var error: Error? {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    /// true means during incremental loading
    public var isIncremental: Bool = false {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    /// A observed object to pass through the image manager loading status to indicator
    public var indicatorStatus = IndicatorStatus()
    
    weak var currentOperation: SDWebImageOperation? = nil

    var currentURL: URL?
    var transaction = Transaction()
    var successBlock: ((PlatformImage, Data?, SDImageCacheType) -> Void)?
    var failureBlock: ((Error) -> Void)?
    var progressBlock: ((Int, Int) -> Void)?
    
    public init() {}
    
    /// Start to load the url operation
    /// - Parameter url: The image url
    /// - Parameter options: The options to use when downloading the image. See `SDWebImageOptions` for the possible values.
    /// - Parameter context: A context contains different options to perform specify changes or processes, see `SDWebImageContextOption`. This hold the extra objects which `options` enum can not hold.
    public func load(url: URL?, options: SDWebImageOptions = [], context: [SDWebImageContextOption : Any]? = nil) {
        let manager: SDWebImageManager
        if let customManager = context?[.customManager] as? SDWebImageManager {
            manager = customManager
        } else {
            manager = .shared
        }
        if (currentOperation != nil && currentURL == url) {
            return
        }
        currentURL = url
        self.indicatorStatus.isLoading = true
        self.indicatorStatus.progress = 0
        currentOperation = manager.loadImage(with: url, options: options, context: context, progress: { [weak self] (receivedSize, expectedSize, _) in
            // This block may be called in non-main thread
            guard let self = self else {
                return
            }
            let progress: Double
            if (expectedSize > 0) {
                progress = Double(receivedSize) / Double(expectedSize)
            } else {
                progress = 0
            }
            self.indicatorStatus.progress = progress
            if let progressBlock = self.progressBlock {
                DispatchQueue.main.async {
                    progressBlock(receivedSize, expectedSize)
                }
            }
        }) { [weak self] (image, data, error, cacheType, finished, _) in
            guard let self = self else {
                return
            }
            if let error = error as? SDWebImageError, error.code == .cancelled {
                // Ignore user cancelled
                // There are race condition when quick scroll
                // Indicator modifier disapper and trigger `WebImage.body`
                // So previous View struct call `onDisappear` and cancel the currentOperation
                return
            }
            withTransaction(self.transaction) {
                self.image = image
                self.error = error
                self.isIncremental = !finished
                if finished {
                    self.imageData = data
                    self.cacheType = cacheType
                    self.indicatorStatus.isLoading = false
                    self.indicatorStatus.progress = 1
                    if let image = image {
                        self.successBlock?(image, data, cacheType)
                    } else {
                        self.failureBlock?(error ?? NSError())
                    }
                }
            }
        }
    }
    
    /// Cancel the current url loading
    public func cancel() {
        if let operation = currentOperation {
            operation.cancel()
            currentOperation = nil
        }
        indicatorStatus.isLoading = false
        currentURL = nil
    }
    
}

// Completion Handler
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
extension ImageManager {
    /// Provide the action when image load fails.
    /// - Parameters:
    ///   - action: The action to perform. The first arg is the error during loading. If `action` is `nil`, the call has no effect.
    public func setOnFailure(perform action: ((Error) -> Void)? = nil) {
        self.failureBlock = action
    }
    
    /// Provide the action when image load successes.
    /// - Parameters:
    ///   - action: The action to perform. The first arg is the loaded image, the second arg is the loaded image data, the third arg is the cache type loaded from. If `action` is `nil`, the call has no effect.
    public func setOnSuccess(perform action: ((PlatformImage, Data?, SDImageCacheType) -> Void)? = nil) {
        self.successBlock = action
    }
    
    /// Provide the action when image load progress changes.
    /// - Parameters:
    ///   - action: The action to perform. The first arg is the received size, the second arg is the total size, all in bytes. If `action` is `nil`, the call has no effect.
    public func setOnProgress(perform action: ((Int, Int) -> Void)? = nil) {
        self.progressBlock = action
    }
}
