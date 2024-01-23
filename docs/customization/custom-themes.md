# Custom themes

Keycloak provides theme support for web pages and emails. This allows customizing the look and feel of end-user facing pages, and they can be integrated with your applications.

## Theme types

A theme can provide one or more types to customize different aspects of Keycloak. The available types are:

| Type | Description |
| --- | --- |
| Common | Files (resources) shared with all theme types |
| Account | Account management |
| Admin | Admin console |
| Emails | Email templates that can be customized for emails sent by Keycloak. |
| Login | User facing public pages like login, password reset and so on. |
| Welcome | The welcome page shown when spinning up Keycloak and opening its landing page. |

## Configuring theme

All theme types, except welcome, are configured through the `Admin Console`. To change the theme used for a realm open the `Admin Console`, select your realm from the drop-down box in the top left corner. Under Realm Settings click Themes.

> **_Note:_**
>
> To set the theme for the `master` admin console you need to set the admin console theme for the `master` realm. To view the changes to the admin console refresh the page.

## Default themes

Keycloak comes bundled with default themes in the server root themes directory. To upgrade, do not edit the bundled themes directly. Instead, create your own theme that extends one of the bundled themes.

## Creating a theme

A theme consists of:

- HTML templates (Freemarker Templates)
- Images
- Message bundles
- Stylesheets
- Scripts
- Theme properties

To replace every page extend the existing theme (`keycloak` theme), and extend the base theme to change the look and feel of the pages. The base theme primarily consists of HTML templates and message bundles, while the `keycloak` theme primarily contains images and stylesheets.

When extending a theme you can override individual resources (templates, stylesheets, etc.). To override HTML templates you need to update your custom template when upgrading to a new release as it could break.

Create a new directory in the `themes` directory and create a new theme. The name of the directory becomes the name of the theme. For example to create a theme called `hcl-base` create the directory `themes/hcl-base`.

Inside the `theme` directory create a subdirectory for each of the theme types provided. For example to add the login type to the `hcl-base` theme create the directory `themes/hcl-base/login`.

Create a configration file `theme.properties` and add following content:

```properties
parent=keycloak
import=common/keycloak
```

### Theme properties

Theme properties are set in the file `<THEME TYPE>/theme.properties` in the theme directory.

| Property | Description |
| --- | --- |
| parent | Parent theme to extend |
| import | Import resources from another theme |
| styles | Space-separated list of styles to include |
| locales | Comma-separated list of supported locales |

Use theme list properties to change the css class used for certain element types. For a list of these properties look at the `theme.properties` file in the corresponding type of the `keycloak` theme (`themes/keycloak/<THEME TYPE>/theme.properties`). You can also add custom properties if needed.


### Stylesheets

A theme can have one or more stylesheets. To add a stylesheet create a file in the `<THEME TYPE>/resources/css` directory of your theme. Then add it to the `styles` property in `theme.properties`.

For example to add `login.css` to the `hcl-base` create `themes/hcl-base/login/resources/css/login.css` with the following content:

```css
.login-pf body {
    background: DimGrey none;
}
```

Then edit `themes/hcl-base/login/theme.properties` and add:

```properties
styles=css/login.css
```

> **_Note:_**
>
> This will only apply styles from your custom stylesheet.
To include the styles from the parent theme you need to load the styles from that theme by editing `themes/hcl-base/login/theme.properties` and changing styles to:

```properties
styles=web_modules/@patternfly/react-core/dist/styles/base.css web_modules/@patternfly/react-core/dist/styles/app.css node_modules/patternfly/dist/css/patternfly.min.css node_modules/patternfly/dist/css/patternfly-additions.min.css lib/pficon/pficon.css css/login.css
```

> **_Note:_**
>
> To override styles from the parent stylesheets it is important that your stylesheet is listed last.

### Scripts

A theme can have one or more scripts, to add a script create a file in the `<THEME TYPE>/resources/js` directory of your theme. Then add it to the scripts property in `theme.properties`.

For example to add script.js to the `hcl-base` create `themes/hcl-base/login/resources/js/script.js` with the following content:

```js
alert('Hello');
```

Then edit `themes/hcl-base/login/theme.properties` and add:

```properties
scripts=js/script.js
```

### Images

To make images available to the theme add them to the `<THEME TYPE>/resources/img` directory of your theme. These are used within stylesheets or directly in HTML templates.

For example to add an image to the `hcl-base` copy an image to `themes/hcl-base/login/resources/img/image.jpg`. You can then use this image within a custom stylesheet as shown:


```css
body {
    background-image: url('../img/image.jpg');
    background-size: cover;
}
```

Or to use directly in HTML templates add the following to a custom HTML template:

```html
<img src="${url.resourcesPath}/img/image.jpg">
```

### Messages

Freemarker templates (FTL) loads all the messages from a message bundle. If a theme is extending an existing theme, it will inherit all the messages from its parents message bundle. You can also override individual messages by adding `<THEME TYPE>/messages/messages_en.properties` file to the theme.

For example to override `Username` in the `hcl-base` theme on the login form, create the file `themes/hcl-base/login/messages/messages_en.properties` with the following content:

```properties
usernameOrEmail=User
```

Within a message values like `{0}` and `{1}` are replaced with arguments when the message is used. For example `{0}` in `Log in to {0}` is replaced with the name of the realm.

### Internationalization

Keycloak supports internationalization. To enable internationalization for a realm see [Server Administration Guide](https://www.keycloak.org/docs/latest/server_admin/#enabling-internationalization). This section describes how you can add your own language.

To add a new language create the file `<THEME TYPE>/messages/messages_<LOCALE>.properties` in the directory of your theme. Then add it to the `locales` property in `<THEME TYPE>/theme.properties`. For a language to be available to users the realms `login`, `account` and `email` theme has to support the language, so you need to add your language for those theme types.

For example, to add Norwegian translations to the `hcl-base` theme create the file `themes/hcl-base/login/messages/messages_no.properties` with the following content:

```properties
usernameOrEmail=Brukernavn
password=Passord
```

All messages provide are not translated. You can use the default English translation.

Then edit `themes/hcl-base/login/theme.properties` and add:

```properties
locales=en,no
```

To add a translation for the language selector. This is done by adding a message to the English translation. To do this add the following to `themes/hcl-base/account/messages/messages_en.properties` and `themes/hcl-base/login/messages/messages_en.properties`:

```properties
locale_no=Norsk
```

By default, message properties files should be encoded using ISO-8859-1 and specify the encoding using a special header. For example to use UTF-8 encoding:

```properties
# encoding: UTF-8
usernameOrEmail=....
```

For more information on how the current locale is selected, see [Locale Selector](https://www.keycloak.org/docs/latest/server_admin/#_user_locale_selection).

### HTML templates

Keycloak uses [Freemarker Templates](https://freemarker.apache.org/) in order to generate HTML. You can override individual templates in your own theme by creating `<THEME TYPE>/<TEMPLATE>.ftl`. For a list of templates used see `themes/base/<THEME TYPE>`.

When creating a custom template copy the template from the base theme to your own theme, then apply the modifications you need. Bear in mind when upgrading to a new version of Keycloak you need to update your custom templates to apply changes to the original template if applicable.

For example to create a custom login form for the `hcl-base` theme, copy `themes/base/login/login.ftl` to `themes/hcl-base/login` and open it in an editor. After the first line (`<#import …​>`) add `<h1>HELLO WORLD!</h1>` like so:

```HTML
<#import "template.ftl" as layout>
<h1>HELLO WORLD!</h1>
...
```

For more information on how to edit templates, see [FreeMarker Manual](https://freemarker.apache.org/docs/index.html).

### Emails

To edit the subject and contents for emails, for example password recovery email, add a message bundle to the email type of your theme. There are three messages for each email. One for the subject, one for the plain text body and one for the html body.

To see all emails available see `themes/base/email/messages/messages_en.properties`.

For example to change the password recovery email for the `hcl-base` `theme create themes/hcl-base/email/messages/messages_en.properties` with the following content:

```properties
passwordResetSubject=My password recovery
passwordResetBody=Reset password link: {0}
passwordResetBodyHtml=<a href="{0}">Reset password</a>
```

### Theme selector

By default, the theme configured for the realm is used, with the except of clients being able to override the login theme. This behavior is changed through the **Theme Selector SPI**.

This could be used to select different themes for desktop and mobile devices by looking at the user agent header, for example.

## Additional references

- [Custom themes for Keycloak](https://git.cwp.pnp-hcl.com/hclds/hclds-keycloak/tree/develop/src/themes)
- [Deploying custom theme](./deploy-custom-theme.md)