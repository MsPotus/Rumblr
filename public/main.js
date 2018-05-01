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
    height: 521,
    transition: 500,
    interval: 2000
});

$(".toggle-password").click(function() {
    $(this).toggleClass("fa-eye fa-eye-slash");
    var input = $($(this).attr("toggle"));
    if (input.attr("type") == "password") {
        input.attr("type", "text");
    } else {
        input.attr("type", "password");
    }
});


// //Scrollspy
// const ss = document.querySelectorAll('.scrollspy');
// M.Scrollspy.init(ss, {});