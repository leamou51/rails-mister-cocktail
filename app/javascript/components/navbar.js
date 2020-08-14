const initUpdateNavbarOnScroll = () => {
  const navbar = document.querySelector('.navbar-lewagon');
  const navLinks = document.querySelectorAll('.navbar-light .navbar-nav .nav-link');
  const navTitle = document.querySelector('.navbar-lewagon h1');

  if (navbar) {
    window.addEventListener('scroll', () => {
      if (window.scrollY >= 200) {
        navbar.classList.add('navbar-lewagon-white');
        navLinks.forEach((navLink) => {
          navLink.classList.remove('text-white');
        });
        navTitle.classList.remove('text-white');
      } else {
        navbar.classList.remove('navbar-lewagon-white');
        navLinks.forEach((navLink) => {
          navLink.classList.add('text-white');
        });
        navTitle.classList.add('text-white');
      }
    });
  }
}

export { initUpdateNavbarOnScroll };
