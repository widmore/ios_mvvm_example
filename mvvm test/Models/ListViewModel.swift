//
//  ListViewModel.swift
//  mvvm test
//
//  Created by Kadir Gönül on 28.08.2018.
//  Copyright © 2018 Kadir Gönül. All rights reserved.
//

import Foundation

class ListViewModel {

    var reloadTableViewClosure : (()->Void)? = nil
    var updateLoadingStatus : (()->Void)? = nil

    private var cellViewModels : [CellViewModel] = [CellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath : Int) -> CellViewModel {
        return cellViewModels[indexPath]
    }
    
    /*var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }*/
    var isLoading : Box<Bool?> = Box(false)
    
    func longProcess (cb: @escaping ()->Void) {
        var list = [CellViewModel]()
        DispatchQueue.global().async {
            for i in 0...5 {
                let y = CellViewModel(name:String(i))
                list.append(y)
            }
            
            sleep(5)
            self.cellViewModels = list
            cb()
        }
    }
    
    func processFetchedInfo () {
        //isLoading = true
        isLoading.value = true
        longProcess() {
            () in
            //self.isLoading = false
            self.isLoading.value = false
        }
    }
}
