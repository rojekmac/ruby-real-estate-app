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
          if (price === "0-3000000" && !(cardPrice < 3000000)) show = false;
          if (
            price === "3000000-6000000" &&
            !(cardPrice >= 3000000 && cardPrice <= 6000000)
          )
            show = false;
          if (
            price === "6000000-10000000" &&
            !(cardPrice >= 6000000 && cardPrice <= 10000000)
          )
            show = false;
          if (price === "10000000+" && !(cardPrice >= 10000000)) show = false;
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
      updateNoResultsMessage();
    });
  }

  // Reset Filters logic
  const resetBtn = document.querySelector(".reset-filters-btn");
  if (resetBtn) {
    resetBtn.addEventListener("click", function () {
      document.getElementById("property-type").value = "";
      document.getElementById("price-range").value = "";
      document.getElementById("bedrooms").value = "";
      document.getElementById("bathrooms").value = "";
      document
        .querySelectorAll(".property-card")
        .forEach((card) => card.classList.add("filtered-in"));
      setupPagination();
      showPage(1);
      updateNoResultsMessage();
    });
  }

  function updateNoResultsMessage() {
    const visibleCards = Array.from(
      document.querySelectorAll(".property-card.filtered-in")
    );
    const noResultsMsg = document.getElementById("no-results-message");
    if (noResultsMsg) {
      if (visibleCards.length === 0) {
        noResultsMsg.style.display = "";
      } else {
        noResultsMsg.style.display = "none";
      }
    }
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

    // Previous button
    if (totalPages > 1) {
      const prevBtn = document.createElement("button");
      prevBtn.className = "pagination-btn";
      prevBtn.textContent = "Previous";
      prevBtn.id = "pagination-prev-btn";
      prevBtn.addEventListener("click", function () {
        if (currentPage > 1) {
          showPage(currentPage - 1);
          updateActivePageBtn(currentPage);
        }
      });
      pagination.appendChild(prevBtn);
    }

    for (let i = 1; i <= totalPages; i++) {
      const btn = document.createElement("button");
      btn.className = "pagination-btn" + (i === 1 ? " active" : "");
      btn.textContent = i;
      btn.dataset.page = i;
      btn.addEventListener("click", function () {
        showPage(i);
        updateActivePageBtn(i);
      });
      pagination.appendChild(btn);
    }
    if (totalPages > 1) {
      const nextBtn = document.createElement("button");
      nextBtn.className = "pagination-btn";
      nextBtn.textContent = "Next";
      nextBtn.addEventListener("click", function () {
        const current = currentPage;
        if (current < totalPages) {
          showPage(current + 1);
          updateActivePageBtn(current + 1);
        }
      });
      nextBtn.id = "pagination-next-btn";
      pagination.appendChild(nextBtn);
    }
    console.log("Pagination buttons generated:", totalPages);
    updatePaginationButtonVisibility(totalPages);
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
    // Update next/prev button visibility
    const totalPages = Math.ceil(cards.length / perPage);
    updatePaginationButtonVisibility(totalPages);
    updateNoResultsMessage();
  }

  function updateActivePageBtn(page) {
    document
      .querySelectorAll(".pagination-btn")
      .forEach((b) => b.classList.remove("active"));
    const btn = document.querySelector(
      ".pagination-btn[data-page='" + page + "']"
    );
    if (btn) btn.classList.add("active");
  }

  function updatePaginationButtonVisibility(totalPages) {
    const nextBtn = document.getElementById("pagination-next-btn");
    if (nextBtn) {
      if (currentPage >= totalPages) {
        nextBtn.style.display = "none";
      } else {
        nextBtn.style.display = "";
      }
    }
    const prevBtn = document.getElementById("pagination-prev-btn");
    if (prevBtn) {
      if (currentPage <= 1) {
        prevBtn.style.display = "none";
      } else {
        prevBtn.style.display = "";
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
