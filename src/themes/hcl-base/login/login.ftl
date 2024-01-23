<#import "login-hcl-template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
<#if section = "form">
<div class="column-flex-box lhs-container vertically-center-child-items horizontally-center-content">
    <div class="column-flex-box horizontally-center-content vertically-center-child-items" style="text-transform: uppercase;">
        <h1>${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</h1>
    </div>
    <div class="column-flex-box login-box">
        <div class="box-title column-flex-box ">
            <div class="row-flex-box horizontally-center-content">
                <#--  Sign into your account?  -->
                ${msg("loginAccountTitle")}
            </div>
        </div>
        <#if message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
            <div class="column-flex-box">
                <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                    <div class="pf-c-alert__icon">
                        <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                        <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                        <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                        <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                    </div>
                    <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                    <span class="icon-close" onclick="removeAlert(this.parentNode)" onkeypress="removeAlert(this.parentNode)" tabindex="1"></span>
                </div>
            </div>
        </#if>
        <div class="column-flex-box login-form">
            <#if realm.password>
                <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                    <#if !usernameHidden??>
                        <div class="column-flex-box login-field-group">
                            <label for="username" class="field-label" <#if locale?? && locale.currentLanguageTag = 'ar'>style="text-align: right;"<#elseif locale?? && locale.currentLanguageTag = 'he'> style="text-align: right;"</#if>><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></label>
                            <input tabindex="1" id="username" class="field-input" name="username" value="${(login.username!'')}"  type="text" autofocus autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                <#if locale?? && locale.currentLanguageTag = 'ar'>style="text-align: right;"<#elseif locale?? && locale.currentLanguageTag = 'he'> style="text-align: right;"</#if>/>
                        </div>        
                    </#if>
                    <div class="column-flex-box login-field-group">
                        <div class="row-flex-box login-label-group-space-between">
                            <label for="password" class="field-label">${msg("password")}</label>
                            <#if realm.resetPasswordAllowed>
                                <span><a class="field-link-label" tabindex="2" href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></span>
                            </#if>
                        </div>
                        <!-- DXQ-29978 - added div wrapper to input as remember me checkbox was displaying before password  -->
                        <div class="row-flex-box login-label-group-space-between">
                            <input tabindex="1" id="password" class="field-input" name="password" type="password" autocomplete="off"
                                aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>"
                                <#if locale?? && locale.currentLanguageTag = 'ar'>style="text-align: right;"<#elseif locale?? && locale.currentLanguageTag = 'he'> style="text-align: right;"</#if>/>
                        </div>
                        <#if realm.rememberMe && !usernameHidden??>
                            <div class="row-flex-box field-checkbox-group">
                                <#if login.rememberMe??>
                                    <input class="field-check-box" tabindex="1" id="rememberMe" name="rememberMe" type="checkbox" checked>
                                <#else>
                                    <input class="field-check-box" tabindex="1" id="rememberMe" name="rememberMe" type="checkbox">
                                </#if>
                                <label for="rememberMe" class="field-checkbox-label">${msg("rememberMe")}</label>
                            </div>
                        </#if>
                    </div>
                    <div class="column-flex-box login-field-group">
                        <div class="row-flex-box">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="1" class="primary-button" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </div>
                    <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
                        <div class="column-flex-box">
                            <div class="row-flex-box horizontally-center-content horizontal-gap">
                            <a class="field-link-label" tabindex="1" href="${url.registrationUrl}">${msg("noAccount")} ${msg("doRegister")}</a>
                            </div>
                        </div>
                    </#if>
                </form>
            </#if>
        </div>
        <#if realm.password && social.providers??>
            <div class="column-flex-box">
                <div id="kc-social-providers" class="full-width ${properties.kcFormSocialAccountSectionClass!}">
                    <hr/>
                    <h4>${msg("identity-provider-login-label")}</h4>
                    <ul class="column-flex-box identity-providers-box <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                        <#list social.providers as p>
                            <div class="secondary-button">
                                <a id="social-${p.alias}" type="button" href="${p.loginUrl}">
                                    <#if p.iconClasses?has_content>
                                        <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                        <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                                    <#else>
                                        <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                                    </#if>
                                </a>
                            </div>
                        </#list>
                    </ul>
                </div>
            </div>
        </#if>
    </div>
    </div>
</div>
</#if>
</@layout.registrationLayout>
