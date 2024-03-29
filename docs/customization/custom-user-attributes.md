# Custom User Attributes

You can add custom user attributes to the registration page and account management console with a custom theme.

## Registration page

Use this procedure to enter custom attributes in the registration page.

### Procedure

1. Copy the template `themes/base/login/register.ftl` to the log in type of your custom theme.

2. Open the copy in an editor.

    For example, to add a mobile number to the registration page, add the following snippet to the form:
        ```html

        <div class="form-group">
        <div class="${properties.kcLabelWrapperClass!}">
            <label for="user.attributes.mobile" class="${properties.kcLabelClass!}">Mobile number</label>
        </div>

        <div class="${properties.kcInputWrapperClass!}">
            <input type="text" class="${properties.kcInputClass!}" id="user.attributes.mobile" name="user.attributes.mobile" value="${(register.formData['user.attributes.mobile']!'')}"/>
        </div>
        </div>
        ```    

3. Ensure the name of the input HTML element starts with `user.attributes`. The attribute is stored by Keycloak with the name mobile.

4. To see the changes, make sure your realm is using your custom theme for the login theme and open the registration page.

## Account Management Console

Use this procedure to manage custom attributes in the user profile page in the account management console.

### Procedure -

1. Copy the template `themes/base/account/account.ftl` to the account type of your custom theme.

2. Open the copy in an editor.

    As an example to add a mobile number to the account page add the following snippet to the form:
        ```html

        <div class="form-group">
        <div class="col-sm-2 col-md-2">
            <label for="user.attributes.mobile" class="control-label">Mobile number</label>
        </div>

        <div class="col-sm-10 col-md-10">
            <input type="text" class="form-control" id="user.attributes.mobile" name="user.attributes.mobile" value="${(account.attributes.mobile!'')}"/>
        </div>
        </div>
        ```

3. Ensure the name of the input HTML element starts with `user.attributes`.

4. To see the changes, make sure your realm is using your custom theme for the account theme and open the user profile page in the account management console.
