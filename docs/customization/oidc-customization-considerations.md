# Customization considerations

A user is redirected to Identity Provider's (IdP) login page to authenticate themsevles before they can access protected resources when using OIDC Authorization Code Flow.

IdPs provide default login page that will authenticate user. This may include Multi-Factor Authentication (MFA) based on how you configure the authentication. In most of the cases the default look and feel of pages may not sufficient and you would want them to be styled based on your brand's identity to provide a seemless user experience.

Customizing the look and feel of the web pages presented is IdP specific. They would have different ways of how you can customize it as well as have limitations on degree of customization available.

Below are some factors you should consider while deciding your customization strategy.

## Custom Layouts

This is one of the most important aspect that will allow you to either completely or partially change the layout of these web pages. Some of IdPs are flexible and allow you to provide these custom layouts using HTML and CSS. While some of the IdPs could provide limited customization options like changing customer logo, name, background image, etc. using a wizard based administration tool.

## Scripting

In most of the cases IdP provide configurable options out of the box. But for adding behaviours that are beyond what an IdP provides, you will have to add them to custom layouts using client side JavaScript. One of the examples could be client side form validation and error handling, this can be handled by providing custom JavaScripts.

## Resources

It might also be necessary for you to provide custom stylesheets, images, fonts and more to support custom layouts. They way these resources are stored and made available to these layouts would be very specific to an IdP. Some could store them alogn side with the custom layouts or use CDN.

## Internationalization

This is completely depdent on your strategy to support multiple languages for your application. There could be scenarios that an IdP does provide you with a way to add additional languages that are not supported out of the box, or you want to add/update the text for desired locales.

In addition if there is requirement to support right to left(RTL) langugage, you will have to build custom layouts keeping this in mind.
