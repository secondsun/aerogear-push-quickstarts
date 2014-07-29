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

import Foundation

public class Contact {
    
    var recId : NSNumber!
    var firstname: String!
    var lastname: String!
    var phoneNumber: String!
    var email: String!
    var birthdate: String!
    
    init() {
    }
    
    init(fromDictionary: [String: AnyObject]) {
        recId = fromDictionary["id"] as? NSNumber
        firstname = fromDictionary["firstName"] as? NSString
        lastname = fromDictionary["lastName"] as? NSString
        phoneNumber = fromDictionary["phoneNumber"] as? NSString
        email = fromDictionary["email"] as? NSString
        birthdate = fromDictionary["birthDate"] as? NSString
    }
    
    func asDictionary() -> [String: AnyObject] {
        var dict = [String: AnyObject]()
        
        dict["id"] = recId
        dict["firstName"] = firstname
        dict["lastName"] = lastname
        dict["phoneNumber"] = phoneNumber
        dict["email"] = email
        dict["birthDate"] = birthdate
        
        return dict
    }    
}
