// // Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "@hotwired/turbo-rails";
// import "controllers";

// // Property filter logic

import "@hotwired/turbo-rails";
import "controllers";

document.addEventListener("turbo:load", function () {
  console.log("Pagination/filter script loaded!");
  // FILTERS
  const filterBtn = document.querySelector(".filter-btn");
  if (filterBtn) {
    filterBtn.addEventListener("click", function (e) {
      e.preventDefault();
      const type = document.getElementById("property-type").value;
      const price = document.getElementById("price-range").value;
      const bedrooms = document.getElementById("bedrooms").value;
      const bathrooms = document.getElementById("bathrooms").value;
      const cards = document.querySelectorAll(".property-card");
      let count = 0;
      cards.forEach((card) => {
        let show = true;
        if (type && card.dataset.type !== type) show = false;
        if (price) {
          const cardPrice = parseInt(card.dataset.price, 10);
          if (price === "0-200000" && !(cardPrice < 200000)) show = false;
          if (
            price === "200000-400000" &&
            !(cardPrice >= 200000 && cardPrice <= 400000)
          )
            show = false;
          if (
            price === "400000-600000" &&
            !(cardPrice > 400000 && cardPrice <= 600000)
          )
            show = false;
          if (price === "600000+" && !(cardPrice > 600000)) show = false;
        }
        if (
          bedrooms &&
          parseInt(card.dataset.bedrooms, 10) < parseInt(bedrooms, 10)
        )
          show = false;
        if (
          bathrooms &&
          parseInt(card.dataset.bathrooms, 10) < parseInt(bathrooms, 10)
        )
          show = false;
        if (show) {
          card.classList.add("filtered-in");
          count++;
        } else {
          card.classList.remove("filtered-in");
        }
      });
      const countEl = document.getElementById("property-count");
      if (countEl) countEl.textContent = count;
      // After filtering, reset pagination to first page
      setupPagination();
      showPage(1);
    });
  }

  // PAGINATION
  let currentPage = 1;
  function setupPagination() {
    const cards = Array.from(
      document.querySelectorAll(".property-card.filtered-in")
    );
    const perPage = 6;
    const totalPages = Math.ceil(cards.length / perPage);
    const pagination = document.querySelector(".pagination");
    if (!pagination) return;
    pagination.innerHTML = "";
    for (let i = 1; i <= totalPages; i++) {
      const btn = document.createElement("button");
      btn.className = "pagination-btn" + (i === 1 ? " active" : "");
      btn.textContent = i;
      btn.addEventListener("click", function () {
        showPage(i);
        document
          .querySelectorAll(".pagination-btn")
          .forEach((b) => b.classList.remove("active"));
        btn.classList.add("active");
      });
      pagination.appendChild(btn);
    }
    if (totalPages > 1) {
      const nextBtn = document.createElement("button");
      nextBtn.className = "pagination-btn";
      nextBtn.textContent = "Next";
      nextBtn.addEventListener("click", function () {
        const current =
          Array.from(pagination.children).findIndex((b) =>
            b.classList.contains("active")
          ) + 1;
        if (current < totalPages) {
          pagination.children[current].click();
        }
      });
      nextBtn.id = "pagination-next-btn";
      pagination.appendChild(nextBtn);
    }
    console.log("Pagination buttons generated:", totalPages);
    updateNextButtonVisibility(totalPages);
  }

  function showPage(page) {
    currentPage = page;
    const allCards = Array.from(document.querySelectorAll(".property-card"));
    const cards = Array.from(
      document.querySelectorAll(".property-card.filtered-in")
    );
    const perPage = 6;
    const start = (page - 1) * perPage;
    const end = start + perPage;
    // Hide all cards by default
    allCards.forEach((card) => (card.style.display = "none"));
    // Show only the paginated filtered-in cards
    cards.forEach((card, i) => {
      card.style.display = i >= start && i < end ? "" : "none";
    });
    // Update count
    const countEl = document.getElementById("property-count");
    if (countEl) countEl.textContent = cards.slice(start, end).length;
    // Update next button visibility
    const totalPages = Math.ceil(cards.length / perPage);
    updateNextButtonVisibility(totalPages);
  }

  function updateNextButtonVisibility(totalPages) {
    const nextBtn = document.getElementById("pagination-next-btn");
    if (nextBtn) {
      if (currentPage >= totalPages) {
        nextBtn.style.display = "none";
      } else {
        nextBtn.style.display = "";
      }
    }
  }

  // Initial setup: mark all as filtered-in
  document
    .querySelectorAll(".property-card")
    .forEach((card) => card.classList.add("filtered-in"));
  setupPagination();
  showPage(1);
});
