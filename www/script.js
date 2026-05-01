document.addEventListener("DOMContentLoaded", function () {
  alert("Welcome to Epiwave!");
});

Shiny.addCustomMessageHandler("copy-code", function(text) {
  
  // fallback for non-HTTPS or permission-blocked clipboard
  function fallbackCopy(text) {
    const textarea = document.createElement("textarea");
    textarea.value = text;
    textarea.style.position = "fixed";   
    textarea.style.opacity  = "0";
    document.body.appendChild(textarea);
    textarea.focus();
    textarea.select();
    
    try {
      document.execCommand("copy");
      showToast("Copied!");
    } catch (err) {
      showToast("Copy failed — please copy manually.");
    }
    
    document.body.removeChild(textarea);
  }

  function showToast(msg) {
    const existing = document.getElementById("epiwave-toast");
    if (existing) existing.remove();

    const toast = document.createElement("div");
    toast.id = "epiwave-toast";
    toast.innerText = msg;
    toast.style.cssText = `
      position: fixed;
      bottom: 30px;
      right: 30px;
      background: #323232;
      color: #fff;
      padding: 12px 22px;
      border-radius: 6px;
      font-size: 15px;
      z-index: 9999;
      opacity: 1;
      transition: opacity 0.5s ease;
    `;
    document.body.appendChild(toast);
    
    
    setTimeout(() => { toast.style.opacity = "0"; }, 2000);
    setTimeout(() => { toast.remove(); }, 2500);
  }

  if (navigator.clipboard && window.isSecureContext) {
    navigator.clipboard.writeText(text)
      .then(() => showToast("Copied!"))
      .catch(() => fallbackCopy(text));
  } else {
    fallbackCopy(text);
  }

});