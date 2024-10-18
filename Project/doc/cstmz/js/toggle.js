// var toggleButton = document.getElementsByTagName('dark-mode-toggle');
// console.log(typeof(toggleButton));
// console.log(DarkModeToggle.title);
// console.log(DarkModeToggle.userPreference);
// console.log(typeof(DarkModeToggle.userPreference));
window.addEventListener('click', invert)
function invert()
{
    if (DarkModeToggle.userPreference) {
        // console.log("Dark Mode");
        document.getElementById("microchip").style.filter="invert(100%)";;
		document.getElementById("makelogo").style.filter="invert(100%)";;
    } else if (!DarkModeToggle.userPreference) {
        // console.log("Light Mode");
        document.getElementById("microchip").style.filter="invert(0%)";;
		document.getElementById("makelogo").style.filter="invert(0%)";;
    }
}
window.addEventListener("DOMContentLoaded", invert);
