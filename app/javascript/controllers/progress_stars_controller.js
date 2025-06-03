
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["star"]


import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
  document.addEventListener('turbo:load', function () {
  document.querySelectorAll('.progress-stars').forEach(progressDiv => {
    const stars = progressDiv.querySelectorAll('.star');
    const groupId = progressDiv.dataset.groupId;
    const checkmark = document.getElementById('checkmark-21-' + groupId);

    stars.forEach((star, index) => {
      star.addEventListener('click', function () {
        const icon = star.querySelector('i');
        star.classList.toggle('checked');

        if (star.classList.contains('checked')) {
          icon.classList.remove('fa-regular');
          icon.classList.add('fa-solid');
          icon.style.color = 'gold';
        } else {
          icon.classList.remove('fa-solid');
          icon.classList.add('fa-regular');
          icon.style.color = 'gray';
        }


  connect() {
    console.log("✅ ProgressStarsController connected")
    this.groupId = this.element.dataset.groupId || 'default'
    this.checkmark = document.getElementById(`checkmark-21-${this.groupId}`) || document.getElementById("checkmark-21")
    this.localStorageKey = `starProgress_${this.groupId}`

    const savedState = JSON.parse(localStorage.getItem(this.localStorageKey)) || []
    this.starTargets.forEach((star, index) => {
      const icon = star.querySelector('i')
      if (savedState[index]) {
        star.classList.add('checked')
        icon.classList.replace('fa-regular', 'fa-solid')
        icon.style.color = 'gold'
        if (index === 20 && this.checkmark) {
          this.checkmark.style.color = 'green'
        }
      }
      star.addEventListener('click', () => this.toggleStar(index, star))
    })
  }

  toggleStar(index, star) {
    const icon = star.querySelector('i')
    const isChecked = star.classList.toggle('checked')

    if (isChecked) {
      icon.classList.replace('fa-regular', 'fa-solid')
      icon.style.color = 'gold'
    } else {
      icon.classList.replace('fa-solid', 'fa-regular')
      icon.style.color = 'gray'
    }

    if (index === 20 && this.checkmark) {
      this.checkmark.style.color = isChecked ? 'green' : 'gray'
    }

    const newState = this.starTargets.map(s => s.classList.contains('checked'))
    localStorage.setItem(this.localStorageKey, JSON.stringify(newState))


    const sparkle = document.createElement('div')
    sparkle.classList.add('sparkle')
    star.appendChild(sparkle)
    setTimeout(() => sparkle.remove(), 500)
  }
}

        const sparkle = document.createElement('div');
        sparkle.classList.add('sparkle');
        star.appendChild(sparkle);

        setTimeout(() => {
          sparkle.remove();
        }, 500);
      });
    });
  });
});
  }
}




// document.addEventListener('turbo:load', function () {
//   document.querySelectorAll('.progress-stars').forEach(progressDiv => {
//     const stars = progressDiv.querySelectorAll('.star');
//     const groupId = progressDiv.dataset.groupId;
//     const checkmark = document.getElementById('checkmark-21-' + groupId);

//     stars.forEach((star, index) => {
//       star.addEventListener('click', function () {
//         const icon = star.querySelector('i');
//         star.classList.toggle('checked');

//         if (star.classList.contains('checked')) {
//           icon.classList.remove('fa-regular');
//           icon.classList.add('fa-solid');
//           icon.style.color = 'gold';
//         } else {
//           icon.classList.remove('fa-solid');
//           icon.classList.add('fa-regular');
//           icon.style.color = 'gray';
//         }

//         if (index === 20) {
//           if (star.classList.contains('checked')) {
//             checkmark.style.color = 'green';
//           } else {
//             checkmark.style.color = 'gray';
//           }
//         }

//         const sparkle = document.createElement('div');
//         sparkle.classList.add('sparkle');
//         star.appendChild(sparkle);

//         setTimeout(() => {
//           sparkle.remove();
//         }, 500);
//       });
//     });
//   });
// });

