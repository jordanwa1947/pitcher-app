function toggleOtherRestaurantsHeight() {
  let container = document.getElementById("other-wishlists");
  let element = document.getElementById("other-wishlists-heading");
  if (container.style.height == "50px") {
    container.style.height = "auto"
    element.innerText = "[ - ] Other Locations"
  } else {
    container.style.height = "50px"
    element.innerText = "[ + ] Other Locations"
  }
}
