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

class ValidationTextfield: UITextField {
    
    @IBOutlet var validationStrategy: ValidationStrategy!

    override func awakeFromNib() {
        super.awakeFromNib();

        setup()
    }

    func setup() {
        // subscribe to get notif for textfield events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "textFieldDidEndEditing:", name: UITextFieldTextDidEndEditingNotification, object: self)
    }

    func validate() -> Bool {
        let isValid = validationStrategy.validate(self.text);
        
        self.layer.borderWidth = 1.0;
        
        if (!isValid) {
            self.layer.borderColor = UIColor(hue:0, saturation:1, brightness:1, alpha:1).CGColor;
        } else {
            self.layer.borderColor = UIColor(hue:0.333, saturation:1, brightness:0.75, alpha:1).CGColor;
        }

        return isValid;
    }

    // MARK: - UITextField notification handling

    func textFieldDidEndEditing(notification: NSNotification) {
        self.resignFirstResponder()
    
        self.validate()
    }
}
