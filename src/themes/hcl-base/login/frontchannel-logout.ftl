<#import "template.ftl" as layout>
<@layout.registrationLayout; section>
    <#if section = "header">
        <script>
            document.title =  "${msg("frontchannel-logout.title")}";
        </script>
        ${msg("frontchannel-logout.title")}
        <br>
    <#elseif section = "form">
        <p>${msg("frontchannel-logout.message")}</p>
       
        <ul class="app_list">
        <#list logout.clients as client>
            <li>
                ${client.name}
                <iframe src="${client.frontChannelLogoutUrl}" style="display:none;"></iframe>
            </li>
        </#list>
        </ul>
        <#if logout.logoutRedirectUri?has_content>
            <script>
                function readystatechange(event) {
                    if (document.readyState=='complete') {
                         setTimeout(() => {
                            window.location.replace('${logout.logoutRedirectUri}');
                        }, "50000");
                    }
                }
                document.addEventListener('readystatechange', readystatechange);
            </script>
            <br>
            <a id="continue" class="${properties.kcButtonClass!} ${properties.kcButtonPrimaryClass!}" href="${logout.logoutRedirectUri}">${msg("doContinue")}</a>
        </#if>
    </#if>
</@layout.registrationLayout>
