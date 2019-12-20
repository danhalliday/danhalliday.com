(function(CSS, document) {

  // Set a fallback flag if the browser doesn’t support variable fonts.

  // It’s tricky to do this correctly in pure CSS, as adding a variable font progressively
  // using @supports results in most browsers loading a bunch of the (many, in our case)
  // fallback fonts anyway and wasting a ton of bandwidth.

  function browserSupportsVariableFonts(CSS) {
    if (typeof CSS === "undefined") { return false }
    if ("supports" in CSS === false) { return false }

    return CSS.supports("(font-variation-settings: normal)")
  }

  function setVariableFontSupportFlag(value) {
    document.querySelector("body").dataset.dFontVariable = value
  }

  setVariableFontSupportFlag(browserSupportsVariableFonts(CSS))

})(window.CSS, window.document);
