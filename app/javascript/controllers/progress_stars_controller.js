import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]

  connect() {
    this.userId = this.element.dataset.progressStarsUserId
    this.currentUserId = this.element.dataset.progressStarsCurrentUserId
    console.log(this.element)
    this.goalId = this.element.dataset.goalId
    this.groupId = this.element.dataset.groupId

    if (this.userId !== this.currentUserId) {
      this.disableStars()
    } else {
      this.loadState()  // restore from localStorage
      this.starTargets.forEach(star => {
        star.addEventListener("click", () => this.toggleStar(star))
      })
    }
  }

  disableStars() {
    this.starTargets.forEach(star => {
      star.classList.remove("clickable")
      star.style.pointerEvents = "none"
    })
  }

  // Load completion state from localStorage and mark stars checked
  loadState() {
    const saved = localStorage.getItem(this.storageKey())
    if (!saved) return

    const completedDays = JSON.parse(saved) // e.g. [0,1,2,4]
    this.starTargets.forEach(star => {
      const day = parseInt(star.dataset.day)
      const isChecked = completedDays.includes(day)
      star.classList.toggle("checked", isChecked)
      const icon = star.querySelector("i")
      icon.classList.toggle("fa-solid", isChecked)
      icon.classList.toggle("fa-regular", !isChecked)
      icon.style.color = isChecked ? "gold" : "gray"
    })

    // Update checkmark color on load
    const totalChecked = completedDays.length
    console.log(totalChecked)
    const checkmark = document.querySelector(`#checkmark-21-${this.userId}`)
    console.log(checkmark)
    if (checkmark) {
      checkmark.style.color = totalChecked >= 21 ? "#3cd53c" : "white"
    }
  }

  // Save current completion state to localStorage
  saveState() {
    const completedDays = this.starTargets
      .filter(star => star.classList.contains("checked"))
      .map(star => parseInt(star.dataset.day))
    localStorage.setItem(this.storageKey(), JSON.stringify(completedDays))
  }

  // Unique key for localStorage per user & goal
  storageKey() {
    return `progress-${this.goalId}-${this.userId}`
  }

  toggleStar(star) {
    const icon = star.querySelector("i");
    const day = parseInt(star.dataset.day);
    const isChecked = star.classList.toggle("checked");

    icon.classList.toggle("fa-solid", isChecked);
    icon.classList.toggle("fa-regular", !isChecked);
    icon.style.color = isChecked ? "gold" : "gray";

    // Update server
    fetch(`/groups/${this.groupId}/goal_completions/update_progress`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
      },
      body: JSON.stringify({
        day: day - 1,
        completed: isChecked,
      }),
    })


    // Update checkmark color
    const totalChecked = this.starTargets.filter(s => s.classList.contains("checked")).length
    console.log({totalChecked})
    const checkmark = document.querySelector(`#checkmark-21-${this.userId}`)
    console.log({userId: this.userId})
    console.log({checkmark})
    if (checkmark) {
      checkmark.style.color = totalChecked >= 21 ? "#3c9d3c" : "#ffffff"
    }
    if (totalChecked >= 21) {
      this.showCongratulationsMessage();
    }


    // Save to localStorage
    this.saveState()

    // Sparkle effect
    const sparkle = document.createElement("div")
    sparkle.classList.add("sparkle")
    star.appendChild(sparkle)
    setTimeout(() => sparkle.remove(), 500)
  }

  showCongratulationsMessage() {
    console.log("congratulation");
    const message = document.createElement("div");
    message.classList.add("congrats-message");
    message.innerHTML = "🎉 Congratulations!<br> You've unstopabble! 🚀";

    document.body.appendChild(message);

    setTimeout(() => {
      message.style.opacity = "0";
      setTimeout(() => message.remove(), 500);
    }, 3000);
  }
}
