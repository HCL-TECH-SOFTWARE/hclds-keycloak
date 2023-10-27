## Setting up workflow between Azure AD(IDP) and Keycloak(SP) using SAML

On a high level, the following tasks will be executed to establish this configuration:
 
- Creating a Directory on Azure portal 
- Create a new Application using the Azure portal
- Configure keycloak realm and client
- Create Identity provider against keycloak realm

    
## Creating a Directory on Azure portal
         
- Browse to the <a href='https://portal.azure.com/'>Azure portal</a> and sign in with an account that has an Azure subscription.
- Select the plus icon (+) and search for Azure Active Directory.

    ![Azure_SAML_Config](./images/Azure_SAML_Config.png)

- Select Create

    ![Azure_SAML_Config_1](./images/Azure_SAML_Config_1.png)

- Provide an Organization name and an Initial domain name. Then select Create. Your directory is created.

    ![Azure_SAML_Config_2](./images/Azure_SAML_Config_2.png)

## <a href='https://learn.microsoft.com/en-us/azure/active-directory/manage-apps/add-application-portal'> Create a new Application using the Azure portal </a>

- Select Azure Active Directory from menu
- Under Manage, select Enterprise Application -> New Application

    ![Azure_SAML_Config_3](./images/Azure_SAML_Config_3.png)

- Create your own application
- Enter Name of app , select Non-Gallery from options and click create

    ![Azure_SAML_Config_4](./images/Azure_SAML_Config_4.png)

- Once application is created, select single sign on from overview page.

    ![Azure_SAML_Config_5](./images/Azure_SAML_Config_5.png)

- Select sign on method as SAML
- Enter Identifier as your Realm URL that you have configured in Keycloak Server and Reply URL as your Endpoint  and Click Save. Those URLS are from your keycloak realm. For configuration of realm please see configuration of keycloak at bottom.

    ![Azure_SAML_Config_6](./images/Azure_SAML_Config_6.png)

    ![Azure_SAML_Config_7](./images/Azure_SAML_Config_7.png)

- Click Save
- From SAML certificate tab download the Federated Metadata XML. It will be used while creating provider in your keycloak server

    ![Azure_SAML_Config_8](./images/Azure_SAML_Config_8.png)

- Select Assign users and groups if facing any issue while logging through azure. <a href='https://learn.microsoft.com/en-us/azure/active-directory/manage-apps/add-application-portal-assign-users'> Create and assign a user account </a>

    ![Azure_SAML_Config_9](./images/Azure_SAML_Config_9.png)

- Add user/group

    ![Azure_SAML_Config_10](./images/Azure_SAML_Config_10.png)

- Click on Users None selected

    ![Azure_SAML_Config_11](./images/Azure_SAML_Config_11.png)

- Select the user
- Select and assign

    ![Azure_SAML_Config_12](./images/Azure_SAML_Config_12.png)

## Configure keycloak realm and client

- Login to keycloak Server’s "Administrative Console"
- Once Logged in you will find  “Add Relam” button on LHS menu. Click the same.
- Provide your realm name & click create Button.
- Once Realm get created, go to “Clients” option in LHS menu & click “Client” option.
- Provide Client ID & Save the client by clicking “Save” button
- It will redirect you to client settings page.
- Change Access Type, Valid Redirect URL & Enable Session state option.
- After saving, new tab named ‘Credentials’ will appear.
- Secret key will be used while setting up client in WAS as
- Go to Mapper and click “Create” button to create new mapper
- Provide the required values and click save. (Client Value should same as your realm name)
- Client setup is complete.

## Create Identity provider against keycloak realm

- Login to keycloak server: https://&lt;KEYCLOAK_HOST&gt;/auth
- Select administrator control and select realm where we want to add IDP
- Click on Identity provider from LHS menu
- Select SAML v2.0 from add provider list.

    ![Azure_SAML_Config_13](./images/Azure_SAML_Config_13.png)

- Upload the downloaded Metadata xml file from azure application under Import config from file section

    ![Azure_SAML_Config_14](./images/Azure_SAML_Config_14.png)

- Once file successfully imported, this will auto populate all required fields in IDP creation.

    ![Azure_SAML_Config_15](./images/Azure_SAML_Config_15.png)

- Add Single logout service URL in IDP configuration , to get this url logon to azure portl -> Enterprise application -> select application -> click on setup single sign on -> copy logout url from set up box

    ![Azure_SAML_Config_16](./images/Azure_SAML_Config_16.png)
    
- Copy the redirect URL from this IDP: this redirect URL need to be added against the newly registered APP inside azure portal. For BASIC SAML Configuration

    ![Azure_SAML_Config_17](./images/Azure_SAML_Config_17.png)

- Also copy the same rediret url as Logout URL in azure application

    ![Azure_SAML_Config_18](./images/Azure_SAML_Config_18.png)

- IDP successfully created.

