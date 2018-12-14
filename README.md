# Heroku + Platform Events Quick Start for Salesforce ISV's
# Business Org Component

This example is to demonstrate and serve as a quick start for how large-scale processing can be moved from Salesforce to Heroku.  It consists of four components, each with its own git repository:

1. [Business org](https://github.com/sfisv-heroku/pe-quickstart-bizorg) **(this project)**: A Salesforce application that keeps track of the activity happening in the Customer org and on Heroku
1. [Customer org](https://github.com/sfisv-heroku/pe-quickstart-custorg): A Salesforce application that generates Platform Events
1. [Listener](https://github.com/sfisv-heroku/pe-quickstart-listener): A Heroku application that consumes events and dispatches them to the worker
1. [Worker](https://github.com/sfisv-heroku/pe-quickstart-worker): A Heroku application that receives work from the listener and performs processing on data retrieved from the Customer org

They must be configured in the listed order, due to dependencies (Customer Org and Listener dependent on Business Org and Worker dependent on Listener).

This is an experimental project, which means that:

1. It's work in progress
1. We need your feedback
1. Code contributions are welcome

For more information, please go to the Salesforce Partner Community and view the ["Heroku for ISV's - Quick Start" Chatter Group](https://sfdc.co/herokuisvquickstart "https://sfdc.co/herokuisvquickstart")

## Table of Contents

*   Installation(#installation)
    *   [Installing Heroku Platform Events Quick Start Business Org using Salesforce DX](#installing-heroku-platform-events-quick-start-business-org-using-salesforce-dx)
    *   [Installing Heroku Platform Events Quick Start Business Org using an unlocked package](#installing-heroku-platform-events-quick-start-business-org-using-an-unlocked-package)

## Installation

There are two ways to install the Platform Events Example ISV Business Org App:

*   Using Salesforce DX
*   Using an unlocked package

### Installing Heroku Platform Events Quick Start Business Org using Salesforce DX

This is the recommended installation option for developers who want to experience the app and the code.

1.  Authenticate with your SFDX hub org (if not already done):

    ```
    sfdx force:auth:web:login -d -a myhuborg
    ```

1.  Clone this repository:

    ```
    git clone https://github.com/sfisv-heroku/pe-quickstart-bizorg
    cd pe-quickstart-bizorg
    ```

1.  Create a scratch org, push the app, and open the org:

    ```
    ./scripts/orgInit.sh
    ```

1.  Change the access policy to permit access to the Connected App

    1. Select **CustomerOrgInformation** in the App list and click "Edit"

    2. Change the "Permitted Users" setting to "Admin approved users are pre-authorized" and click Save.

1.  Collect the Client ID and Client Secret for your Connected App:

    1. Go the the App Manager page (from Setup, enter App Manager in the Quick Find box).

    2. Click on the arrow to the right of the **CustomerOrgInformation** row, to reveal the drop-down list and select **View**

    3. Take down the **Consumer Key** for later use (will be called **BIZ_CLIENT_ID**).

    4. Click on **Click to Reveal** next to the **Consumer Secret** and take down the revealed value for later use (will be called **BIZ_CLIENT_SECRET**).

1.  Reset the security token for the current user:

    1. From your personal settings, enter Reset in the Quick Find box, then select **Reset My Security Token**.
    
    2. Click **Reset Security Token**. The new security token is sent to the email address in your Salesforce personal settings (the one associated with your SFDX hub org)

    3. From the email that is sent, note the security token, as it will be required when configuring the related components (will be called **BIZ_TOKEN**).

1.  Collect remaining access information, that will be required for configuring the other components to access the business org:

    1. To get the username and password, execute:
    ```
    sfdx force:user:display
    ```
    2. Take down the following and hold onto them for later use:

    Key in Display | Config Var Name (Future)
    -------------- | -------------
    Org Id         | BIZ_ORG_ID
    Instance Url   | BIZ_URL
    Username       | BIZ_USERNAME
    Password       | BIZ_PASSWORD


### Installing Heroku Platform Events Quick Start Business Org using an unlocked package

This is the recommended option for non developers. Use this option if you want to experience the sample app but do not plan to modify the code.

1.  [Sign up](https://developer.salesforce.com/signup) for a developer edition.

1.  Enable My Domain. Follow the instructions to enable My Domain [here](https://trailhead.salesforce.com/en/modules/identity_login/units/identity_login_my_domain).

1.  Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=xxx) to install the Heroku Platform Events Quick Start Business Org App unlocked package into your developer edition org.

1.  Select **Install for All Users**. When prompted, make sure you grant access to the external sites.
