//
//  ViewController.swift
//  TestAppBeon
//
//  Created by Gabriel Marson on 24/05/22.
//

import UIKit
import Combine

class ViewController: UIViewController {

    @IBOutlet private var factLabel: UILabel!
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var searchButton: UIButton!
    
    private var subscriptions: Set<AnyCancellable> = .init()
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        observe()
    }

    func loadData(number: String) {
        viewModel.getNumber(number: number)
    }
    
    func observe() {
        viewModel.$state.sink { [weak self] state in
            
            DispatchQueue.main.async {
                switch state {
                
                case .idle:
                    break
                case .error:
                    self?.factLabel.text = "Error"
                case .success(let message):
                    self?.factLabel.text = message
                }
            }
        }.store(in: &subscriptions)
    }

    
    @IBAction func search(sender: UIButton?) {
        textField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let number = textField.text else { return }
        loadData(number: number)
    }
}
