// Dropdown menu behavior for the main nav. Desktop mouse users get CSS-only
// hover; this script adds tap support on touch devices, keyboard Escape to
// close, and marks the current page (and its parent dropdown) as active.
(function () {
  var nav = document.querySelector('header nav[aria-label="Main"]');
  if (!nav) return;

  var dropdowns = nav.querySelectorAll('li.has-dropdown');

  function closeAll(except) {
    dropdowns.forEach(function (li) {
      if (li !== except) {
        li.classList.remove('open');
        li.querySelector(':scope > a').setAttribute('aria-expanded', 'false');
      }
    });
  }

  dropdowns.forEach(function (li) {
    var trigger = li.querySelector(':scope > a');
    trigger.setAttribute('aria-expanded', 'false');
    trigger.addEventListener('click', function (e) {
      var isTouch = window.matchMedia('(hover: none)').matches;
      if (!isTouch) return;
      if (li.classList.contains('open')) return; // second tap: follow the link
      e.preventDefault();
      closeAll(li);
      li.classList.add('open');
      trigger.setAttribute('aria-expanded', 'true');
    });
  });

  document.addEventListener('click', function (e) {
    if (!nav.contains(e.target)) closeAll();
  });
  document.addEventListener('keydown', function (e) {
    if (e.key === 'Escape') closeAll();
  });

  // Highlight whichever link matches the current page.
  nav.querySelectorAll('a[href]').forEach(function (a) {
    var url;
    try {
      url = new URL(a.getAttribute('href'), location.href);
    } catch (e) {
      return;
    }
    if (url.pathname === location.pathname) {
      a.setAttribute('aria-current', 'page');
      var parent = a.closest('li.has-dropdown');
      if (parent && parent.querySelector(':scope > a') !== a) {
        parent.querySelector(':scope > a').classList.add('current-group');
      }
    }
  });
})();
