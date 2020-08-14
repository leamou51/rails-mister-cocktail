import Typed from 'typed.js';

const loadDynamicBannerText = () => {
  new Typed('#banner-typed-text', {
    strings: ["Roll up your sleeves", "and take out your shakers!!"],
    typeSpeed: 100,
    loop: true
  });
}

export { loadDynamicBannerText };
