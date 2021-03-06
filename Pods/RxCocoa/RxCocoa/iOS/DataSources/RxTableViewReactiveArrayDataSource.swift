//
//  RxTableViewReactiveArrayDataSource.swift
//  RxCocoa
//
//  Created by Krunoslav Zaher on 6/26/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift

// objc monkey business
class _RxTableViewReactiveArrayDataSource
    : NSObject
    , UITableViewDataSource {
    
    func numberOfSections(in tableViewSearch: UITableView) -> Int {
        return 1
    }
   
    func _tableView(_ tableViewSearch: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableViewSearch: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView(tableViewSearch, numberOfRowsInSection: section)
    }

    fileprivate func _tableView(_ tableViewSearch: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        rxAbstractMethod()
    }

    func tableView(_ tableViewSearch: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _tableView(tableViewSearch, cellForRowAt: indexPath)
    }
}


class RxTableViewReactiveArrayDataSourceSequenceWrapper<S: Sequence>
    : RxTableViewReactiveArrayDataSource<S.Iterator.Element>
    , RxTableViewDataSourceType {
    typealias Element = S

    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
    }

    func tableView(_ tableViewSearch: UITableView, observedEvent: Event<S>) {
        Binder(self) { tableViewDataSource, sectionModels in
            let sections = Array(sectionModels)
            tableViewDataSource.tableView(tableViewSearch, observedElements: sections)
        }.on(observedEvent)
    }
}

// Please take a look at `DelegateProxyType.swift`
class RxTableViewReactiveArrayDataSource<Element>
    : _RxTableViewReactiveArrayDataSource
    , SectionedViewDataSourceType {
    typealias CellFactory = (UITableView, Int, Element) -> UITableViewCell
    
    var itemModels: [Element]? = nil
    
    func modelAtIndex(_ index: Int) -> Element? {
        return itemModels?[index]
    }

    func model(at indexPath: IndexPath) throws -> Any {
        precondition(indexPath.section == 0)
        guard let item = itemModels?[indexPath.item] else {
            throw RxCocoaError.itemsNotYetBound(object: self)
        }
        return item
    }

    let cellFactory: CellFactory
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    override func _tableView(_ tableViewSearch: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModels?.count ?? 0
    }
    
    override func _tableView(_ tableViewSearch: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory(tableViewSearch, indexPath.item, itemModels![indexPath.row])
    }
    
    // reactive
    
    func tableView(_ tableViewSearch: UITableView, observedElements: [Element]) {
        self.itemModels = observedElements
        
        tableViewSearch.reloadData()
    }
}

#endif
