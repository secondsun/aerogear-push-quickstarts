/**
 * JBoss, Home of Professional Open Source
 * Copyright Red Hat, Inc., and individual contributors.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * 	http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.jboss.aerogear.unifiedpush.quickstart;

public interface Constants {

    /**
     *  This is the base url for the contacts-mobile-picketlink-secured application.
     *
     *  In the case of an Android VM the host machine's address would be:
     *  String BASE_URL = "http://10.0.2.2:8080/jboss-contacts-mobile-picketlink-secured";
     */
    String BASE_URL = "";

    /**
     * This is the URL to the Unified Push Server.
     *
     * In the case of an Android VM the host machine's address would be:
     * String UNIFIED_PUSH_URL = "http://10.0.2.2:8080/ag-push";
     *
     */
    String UNIFIED_PUSH_URL = "";

    /**
     * The variant id that which was generated when registering the variant with
     * the UnifiedPush Server.
     */
    String VARIANT_ID = "";

    /**
     * The secret that which was generated when registering the variant with
     * the UnifiedPush Server
     */
    String SECRET = "";

    /**
     * Is the project number given in Googles APIs Console.
     */
    String GCM_SENDER_ID = "";

    String CONTACT = "CONTACT";

}
