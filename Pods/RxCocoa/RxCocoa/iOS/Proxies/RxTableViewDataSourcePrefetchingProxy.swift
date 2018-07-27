//
//  RxTableViewDataSourcePrefetchingProxy.swift
//  RxCocoa
//
//  Created by Rowan Livingstone on 2/15/18.
//  Copyright © 2018 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift

@available(iOS 10.0, tvOS 10.0, *)
extension UITableView: HasPrefetchDataSource {
    public typealias PrefetchDataSource = UITableViewDataSourcePrefetching
}

@available(iOS 10.0, tvOS 10.0, *)
fileprivate let tableViewPrefetchDataSourceNotSet = TableViewPrefetchDataSourceNotSet()

@available(iOS 10.0, tvOS 10.0, *)
fileprivate final class TableViewPrefetchDataSourceNotSet
    : NSObject
    , UITableViewDataSourcePrefetching {

    func tableView(_ tableViewSearch: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {}

}

@available(iOS 10.0, tvOS 10.0, *)
open class RxTableViewDataSourcePrefetchingProxy
    : DelegateProxy<UITableView, UITableViewDataSourcePrefetching>
    , DelegateProxyType
    , UITableViewDataSourcePrefetching {

    /// Typed parent object.
    public weak private(set) var tableViewSearch: UITableView?

    /// - parameter tableView: Parent object for delegate proxy.
    public init(tableViewSearch: ParentObject) {
        self.tableViewSearch = tableViewSearch
        super.init(parentObject: tableViewSearch, delegateProxy: RxTableViewDataSourcePrefetchingProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        self.register { RxTableViewDataSourcePrefetchingProxy(tableViewSearch: $0) }
    }

    fileprivate var _prefetchRowsPublishSubject: PublishSubject<[IndexPath]>?

    /// Optimized version used for observing prefetch rows callbacks.
    internal var prefetchRowsPublishSubject: PublishSubject<[IndexPath]> {
        if let subject = _prefetchRowsPublishSubject {
            return subject
        }

        let subject = PublishSubject<[IndexPath]>()
        _prefetchRowsPublishSubject = subject

        return subject
    }

    private weak var _requiredMethodsPrefetchDataSource: UITableViewDataSourcePrefetching? = tableViewPrefetchDataSourceNotSet

    // MARK: delegate

    /// Required delegate method implementation.
    public func tableView(_ tableViewSearch: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if let subject = _prefetchRowsPublishSubject {
            subject.on(.next(indexPaths))
        }

        (_requiredMethodsPrefetchDataSource ?? tableViewPrefetchDataSourceNotSet).tableView(tableViewSearch, prefetchRowsAt: indexPaths)
    }

    /// For more information take a look at `DelegateProxyType`.
    open override func setForwardToDelegate(_ forwardToDelegate: UITableViewDataSourcePrefetching?, retainDelegate: Bool) {
        _requiredMethodsPrefetchDataSource = forwardToDelegate ?? tableViewPrefetchDataSourceNotSet
        super.setForwardToDelegate(forwardToDelegate, retainDelegate: retainDelegate)
    }

    deinit {
        if let subject = _prefetchRowsPublishSubject {
            subject.on(.completed)
        }
    }

}

#endif

