// = require materialize
// // Side Menu
// const sideNav = document.querySelector('.sidenav');

M.AutoInit();
// Side Menu
const sideNav = document.querySelector('.sidenav');
M.Sidenav.init(sideNav, {});

// Slider
const slider = document.querySelector('.slider');


M.Slider.init(slider, {
    indicators: false,
    height: 500,
    transition: 500,
    interval: 6000
});

//Scrollspy
const ss = document.querySelectorAll('.scrollspy');
M.Scrollspy.init(ss, {});