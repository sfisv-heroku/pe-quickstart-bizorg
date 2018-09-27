# Heroku + Platform Events Quick Start for Salesforce ISV's
# Business Org Component

This example is to demonstrate and serve as a quick start for how large-scale processing can be moved from Salesforce to Heroku.  It consists of four components, each with its own git repository:

1. [Business org](https://github.com/sfisv-heroku/pe-quickstart-bizorg) (this project): A Salesforce application that keeps track of the activity happening in the Customer org and on Heroku
1. [Customer org](https://github.com/sfisv-heroku/pe-quickstart-custorg): A Salesforce application that generates Platform Events
1. [Listener](https://github.com/sfisv-heroku/pe-quickstart-listener) (this project): A Heroku application that consumes events and dispatches them to the worker
1. [Worker](https://github.com/sfisv-heroku/pe-quickstart-worker): A Heroku application that receives work from the listener and performs processing on data retrieved from the Customer org

They must be configured in the listed order, due to dependencies (Customer Org and Listener dependent on Business Org and Worker dependent on Listener)

This is an experimental project, which means that:

1. It's work in progress
1. We need your feedback
1. Code contributions are welcome

For more information, please go to the Salesforce Partner Community and view the ["Heroku for ISV's - Quick Start" Chatter Group](https://sfdc.co/herokuisvquickstart "https://sfdc.co/herokuisvquickstart")

## Table of Contents

*   Installation
    *   [Installing Heroku Platform Events Quick Start Business Org using Salesforce DX](#installing-heroku-pe-quickstart-bizorg-using-salesforce-dx)
    *   [Installing Heroku Platform Events Quick Start Business Org using an unlocked package](#installing-pe-quickstart-bizorg-using-an-unlocked-package)

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


### Installing Heroku Platform Events Quick Start Business Org using an unlocked package

This is the recommended option for non developers. Use this option if you want to experience the sample app but do not plan to modify the code.

1.  [Sign up](https://developer.salesforce.com/signup) for a developer edition.

1.  Enable My Domain. Follow the instructions to enable My Domain [here](https://trailhead.salesforce.com/projects/quickstart-lightning-components/steps/quickstart-lightning-components1).

1.  Click [this link](https://login.salesforce.com/packaging/installPackage.apexp?p0=xxx) to install the Platform Events Example ISV Business Org App unlocked package into your developer edition org.

1.  Select **Install for All Users**. When prompted, make sure you grant access to the external sites.
