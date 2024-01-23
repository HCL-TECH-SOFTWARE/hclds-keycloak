# Customization considerations

A user is redirected to Identity Provider's (IdP) log in page to authenticate before they can access protected resources when using OIDC Authorization Code Flow.

IdPs provides default log in page to authenticate the user. This may include Multi-Factor Authentication (MFA) based on how you configure the authentication. In most of the cases the default look and feel of pages are not sufficient, and you would want them to be styled based on your brand identity to provide a seemless user experience.

Customizing the look and feel of the web pages presented is IdP specific. They are different ways of how you can customize it as well as have limitations on degree of customization available.

Consider following factors while deciding your customization strategy.

## Custom Layouts

This is one of the most important aspect that allows you to either completely or partially change the layout of these web pages. Some of IdPs are flexible and allow you to provide these custom layouts using HTML and CSS. While few IdPs could provide limited customization options like changing customer logo, name, background image, etc. using a wizard based administration tool.

## Scripting

In most of the cases IdP provide configurable options out of the box. But for adding behaviours that are beyond what an IdP provides, you will have to add them to custom layouts using client side JavaScript. One of the examples could be client side form validation and error handling, this can be handled by providing custom JavaScripts.

## Resources

Provides necessary custom stylesheets, images, fonts and more to support custom layouts. The resources are stored and made available to these layouts are specific to an IdP. Some could store them alongside with the custom layouts or use CDN.

## Internationalization

This is completely dependent on your strategy to support multiple languages for your application. There are scenarios that an IdP does provide you with a way to add additional languages that are not supported out of the box, or you want to add/update the text for desired locales.

In addition, if there is requirement to support Right to Left(RTL) language, you have to build custom layouts keeping this in mind.
