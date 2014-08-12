[![Build Status](https://api.travis-ci.org/aerogear/aerogear-push-quickstarts.png?branch=master)](https://travis-ci.org/aerogear/aerogear-push-quickstarts)

aerogear-push-quickstarts
=========================

UnifiedPush Quickstart Examples


* server
  * contacts-mobile-picketlink-secured
  * contacts-mobile-proxy
* client
  * android
  * cordova
  * ios
  * contacts-mobile-webapp


Configure Maven
---------------

### Configure Maven to Build and Deploy the Quickstarts

The quickstarts use artifacts located in the JBoss GA and Early Access repositories. You must configure Maven to use these repositories before you build and deploy the quickstarts.

_Note: These instructions assume you are working with a released version of the quickstarts. If you are working with the quickstarts located in the GitHub master branch, follow the instructions located in the [Contributing Guide](https://github.com/jboss-developer/jboss-wfk-quickstarts/blob/2.7.x-develop/CONTRIBUTING.md#configure-maven)._


1. Clone the repository
`git clone git@github.com:aerogear/aerogear-push-quickstarts.git`

2. `cd aerogear-push-quickstarts`

3. Run

`mvn clean install -DrepositoryId=jboss-earlyaccess-repository -DrepositoryId=jboss-ga-repository --settings settings.xml`

_Note: On Maven 3.2.2 there is a regression and improssible to provide the `--settings` option. Details are [here](https://jira.codehaus.org/browse/MNG-5663)._

### Maven Profiles

Profiles are used by Maven to customize the build environment. The `pom.xml` in the root of the quickstart directory defines the following profiles:

* The `default` profile defines the list of modules or quickstarts that require nothing but JBoss Enterprise Application Platform.
* The `android` profile lists Android quickstarts.
* The `non-maven` profile lists quickstarts that do not require Maven, for example, quickstarts that use other Frameworks or technologies.
* The `functional-tests` profile lists quickstarts that provide functional tests.


Use JBoss Developer Studio or Eclipse to Run the Quickstarts
------------------------------------------------------------

You can also deploy the quickstarts from Eclipse using JBoss tools. For more information on how to set up Maven and the JBoss tools, refer to the [JBoss Enterprise Application Platform Development Guide](https://access.redhat.com/site/documentation/JBoss_Enterprise_Application_Platform/) or [Get Started Developing Applications](http://www.jboss.org/jdf/quickstarts/jboss-as-quickstart/guide/Introduction/ "Get Started Developing Applications").

### Run the Arquillian Tests
----------------------------

Some of the quickstarts provide Arquillian tests. By default, these tests are configured to be skipped, as Arquillian tests an application on a real server, not just in a mocked environment.

You can either start the server yourself or let Arquillian manage its lifecycle during the testing. The individual quickstart README should tell you what to expect in the console output and the server log when you run the test. Note you would need to build quickstarts first before you can run `functional-tests` profile and even if you enable this profile, you still need to select container runtime via `arq-jbossas-remote` or `arq-jbossas-managed` profile.


1. Test the quickstart on a remote server
    * Arquillian's remote container adapter expects a JBoss EAP server instance to be already started prior to the test execution. You must [Start the JBoss EAP server](#start-the-jboss-eap-server) as described in the quickstart README file.
    * If you need to run the tests on a JBoss EAP server running on a machine other than localhost, you can configure this, along with other options, in the `src/test/resources/arquillian.xml` file using the following properties:

            <container qualifier="jboss" default="true">
                <configuration>
                    <property name="managementAddress">myhost.example.com</property>
                    <property name="managementPort">9999</property>
                    <property name="username">customAdminUser</property>
                    <property name="password">myPassword</property>
                </configuration>
            </container>
    * Run the test goal with the following profile activated:

            mvn clean test -Parq-jbossas-remote
2. Test the quickstart on a managed server

    Arquillian's managed container adapter requires that your server is not running as it will start the container for you. However, you must first let it know where to find the JBoss EAP directory. The simplest way to do this is to set the `JBOSS_HOME` environment variable to the full path to your JBoss EAP directory. Alternatively, you can set the path in the `jbossHome` property in the Arquillian configuration file.
    * Open the `src/test/resources/arquillian.xml` file located in the quickstart directory.
    * Find the configuration for the JBoss container. It should look like this:

            <!-- Example configuration for a managed/remote JBoss EAP instance -->
            <container qualifier="jboss" default="true">
                <!-- If you want to use the JBOSS_HOME environment variable, just delete the jbossHome property -->
                <!--<configuration> -->
                <!--<property name="jbossHome">/path/to/jboss/as</property> -->
                <!--</configuration> -->
            </container>
    * Uncomment the `configuration` element, find the `jbossHome` property and replace the "/path/to/jboss/as" value with the actual path to your JBoss EAP server.
    * Run the test goal with the following profile activated:

            mvn clean test -Parq-jbossas-managed

