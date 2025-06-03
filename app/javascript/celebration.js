function showCongratulations(memberName) {
  const message = document.createElement("div");
  message.innerHTML = `<h2>🎉 Well done, ${memberName}! 🎉</h2><p>You've completed 21 days! Keep up the amazing work. 💖</p>`;
  message.style.cssText = "position: fixed; top: 20px; left: 50%; transform: translateX(-50%); background: #FFD700; padding: 15px; border-radius: 10px; text-align: center; font-size: 22px; font-family: 'Poppins', sans-serif;";
  document.body.appendChild(message);

  setTimeout(() => message.remove(), 5000);
}

document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll(".progress-stars").forEach(starContainer => {
    const memberName = starContainer.closest(".member-card").querySelector("h4").innerText;

    starContainer.querySelectorAll(".star").forEach(star => {
      star.addEventListener("click", function () {
        star.classList.toggle("completed");

        if (starContainer.querySelectorAll(".star.completed").length === 21) {
          showCongratulations(memberName);
        }
      });
    });
  });
});
