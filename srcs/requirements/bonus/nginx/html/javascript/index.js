const copyrightYear = document.querySelector("#year");

function updateCopyrightYear() {
  const today = new Date();
  copyrightYear.innerText = today.getFullYear();
}

updateCopyrightYear();
