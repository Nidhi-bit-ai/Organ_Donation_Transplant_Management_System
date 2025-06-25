function togglePassword() {
  const pw = document.getElementById("password");
  pw.type = pw.type === "password" ? "text" : "password";
}

document.getElementById("loginForm").addEventListener("submit", function (e) {
  const username = document.getElementById("username").value;
  const password = document.getElementById("password").value;

  // fake validation: just to demo the error message
  if (username.trim() === "" || password.trim() === "") {
    e.preventDefault();
    const errorBox = document.getElementById("errorMsg");
    errorBox.style.display = "block";
    errorBox.textContent = "⚠️ Both fields are required.";
  }
});
