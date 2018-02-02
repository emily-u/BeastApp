//
//  addViewController.swift
//  redoBeast
//
//  Created by Emily on 1/30/18.
//  Copyright © 2018 Emily. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: class {
    func savelist(by controller: addViewController, title: String, completed: Bool, at indexPath: NSIndexPath?)
}

class addViewController: UIViewController {
    
    var titleField: String?
    
    @IBOutlet weak var titleinput: UITextField!
    weak var delegate: ViewControllerDelegate?
    var indexPath: NSIndexPath?
    
    @IBAction func cancleButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.savelist(by: self, title: titleinput.text!, completed: false, at: indexPath)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        titleinput.delegate = self
        titleinput.text = titleField

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
