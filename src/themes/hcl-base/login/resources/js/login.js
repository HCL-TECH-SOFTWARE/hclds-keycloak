document.addEventListener('click',(e) => openLangPopup(e));

function removeAlert(alert) {
    alert.parentNode.removeChild(alert);
}  

function openLangPopup(e) {
    if(document.getElementById("localeList") && document.getElementById("localeList").classList.contains("showPopup")) {
        document.getElementById("localeList").classList.remove("showPopup");
        document.getElementById("sortIconId").classList.remove("icon-sort-up");
        document.getElementById("sortIconId").classList.add("icon-sort-down");
    } else if(e && (e.target.id==='kc-current-locale-link' || e.target.id==='sortIconId')) {
        document.removeEventListener('click',openLangPopup);
        document.getElementById("localeList").classList.add("showPopup");
        document.getElementById("sortIconId").classList.remove("icon-sort-down");
        document.getElementById("sortIconId").classList.add("icon-sort-up");
    } else if(e && (e.target.id==="logoutInfo" || e.target.id==="closeInfo")) {
        let infoEle = document.getElementById("logoutInfoBox");
        if(infoEle.classList.contains("hidePopup")){
            infoEle.classList.remove("hidePopup");
            infoEle.classList.add("showPopup");
        }
        else{
            infoEle.classList.remove("showPopup");
            infoEle.classList.add("hidePopup");
        }
    }  else {
        document.removeEventListener('click',openLangPopup);
    }
}