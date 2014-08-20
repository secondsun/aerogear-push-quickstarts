/*
 * JBoss, Home of Professional Open Source.
 * Copyright Red Hat, Inc., and individual contributors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import UIKit

protocol ContactDetailsViewControllerDelegate {
    func contactDetailsViewControllerDidCancel(controller: ContactDetailsViewController)
    func contactDetailsViewController(controller: ContactDetailsViewController, didSave contact: Contact)
}

class ContactDetailsViewController: UITableViewController {
    
    @IBOutlet var firstnameTxtField: ValidationTextfield!
    @IBOutlet var lastnameTxtField: ValidationTextfield!
    @IBOutlet var phoneTxtField : ValidationTextfield!
    @IBOutlet var emailTxtField: ValidationTextfield!
    @IBOutlet var birthdateTxtField: ValidationTextfield!
    
    var delegate: ContactDetailsViewControllerDelegate?
    var contact: Contact!
    
    var textfields: [ValidationTextfield]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let contact = self.contact {
            firstnameTxtField.text = contact.firstname
            lastnameTxtField.text = contact.lastname
            phoneTxtField.text = contact.phoneNumber
            emailTxtField.text = contact.email
            birthdateTxtField.text = contact.birthdate
        }
        
        textfields = [firstnameTxtField, lastnameTxtField, phoneTxtField, emailTxtField, birthdateTxtField]
    }
    
    // MARK: - Action Methods
    
    @IBAction func cancel(sender: AnyObject) {
        self.delegate?.contactDetailsViewControllerDidCancel(self)
    }
    
    @IBAction func save(sender: AnyObject) {
        // enumare all textfields and ask them to validate themselves
        
        var invalidForm = false
        
        
        for textfield in textfields {
            if !textfield.validate() {
                invalidForm = true
            }
        }
        
        // if invalid entries found, no need to continue
        if invalidForm {
            return
        }
        
        // else time to create contact
        
        if !(contact != nil) {
            contact = Contact()
        }

        contact.firstname = firstnameTxtField.text
        contact.lastname = lastnameTxtField.text
        contact.phoneNumber = phoneTxtField.text
        contact.email = emailTxtField.text
        contact.birthdate = birthdateTxtField.text
        
        // call delegate to add it
        self.delegate?.contactDetailsViewController(self, didSave: contact)
    }

}
