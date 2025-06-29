// === Property Listings Filtering and Count ===
// (All property filtering/count JS removed. Only keep unrelated or necessary JS below.)

// === Animated Transitions on Scroll ===
document.addEventListener("DOMContentLoaded", function () {
  const animatedEls = document.querySelectorAll(
    ".fade-in, .slide-in-left, .slide-in-right"
  );
  if ("IntersectionObserver" in window) {
    const observer = new IntersectionObserver(
      (entries, obs) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add("visible");
            obs.unobserve(entry.target);
          }
        });
      },
      { threshold: 0.15 }
    );
    animatedEls.forEach((el) => observer.observe(el));
  } else {
    // Fallback for old browsers
    animatedEls.forEach((el) => el.classList.add("visible"));
  }
});
