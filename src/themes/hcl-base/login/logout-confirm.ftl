<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <div class="logoutInfoWrapper">
            <span id="logoutInfo" class="icon-info" onclick="(e)=>openLangPopup(e)"></span>
        </div>
        <div id="logoutInfoBox" class="logoutInfoBox hidePopup">
            <span class="popoverTopArrow"></span>
            <div class="info-close-Wrapper" onclick="(e)=>openLangPopup(e)">
                <span id="closeInfo" style="color: gray;" class="icon-info-close"></span>
            </div>
            <h5><b>${msg("logoutConfirmTitle")}</b></h5>
            <h6>${msg("logoutInfoText1")}</h6>
            <h6>${msg("logoutInfoText2")}</h6>
            <h6>${msg("logoutInfoText3")}</h6>
        </div>
        ${msg("logoutConfirmTitle")}
    <#elseif section = "form">
        <div id="kc-logout-confirm" class="content-area">
            <div <#if locale??><#if locale?? && locale.currentLanguageTag = 'ar'>style="text-align: right;"<#elseif locale?? && locale.currentLanguageTag = 'he'> style="text-align: right;"</#if></#if>>${msg("logoutWarning")}
                <span style="text-transform: uppercase;">${kcSanitize(msg("loginTitleHtml",(realm.displayNameHtml!'')))?no_esc}</span>
            </div>
            <div <#if locale??><#if locale?? && locale.currentLanguageTag = 'ar'>style="text-align: right;"<#elseif locale?? && locale.currentLanguageTag = 'he'> style="text-align: right;"</#if></#if>>${msg("logoutWarning1")}</div>
            <p class="instruction">${msg("logoutConfirmHeader")}</p>

            <form class="form-actions" action="${url.logoutConfirmAction}" method="POST">
                <input type="hidden" name="session_code" value="${logoutConfirm.code}">
                <div class="${properties.kcFormGroupClass!}">
                    <div id="kc-form-options">
                        <div class="${properties.kcFormOptionsWrapperClass!}">
                        </div>
                    </div>

                    <div id="kc-form-buttons" class="${properties.kcFormGroupClass!}">
                        <input tabindex="4"
                               class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!} ${properties.kcButtonBlockClass!} ${properties.kcButtonLargeClass!}"
                               name="confirmLogout" id="kc-logout" type="submit" value="${msg('doLogout')}"/>
                    </div>
                </div>
            </form>

            <div id="kc-info-message">
                <#if logoutConfirm.skipLink>
                <#else>
                    <#if (client.baseUrl)?has_content>
                        <p><a href="${client.baseUrl}" class="${properties.kcButtonClass!} secondary-button ${properties.kcButtonLargeClass!}">${kcSanitize(msg("backToApplication"))?no_esc}</a></p>
                    </#if>
                </#if>
            </div>

            <div class="clearfix"></div>
        </div>
    </#if>
</@layout.registrationLayout>
