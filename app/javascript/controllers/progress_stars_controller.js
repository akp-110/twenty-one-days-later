
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

        if (index === 20) {
          if (star.classList.contains('checked')) {
            checkmark.style.color = 'green';
          } else {
            checkmark.style.color = 'gray';
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
