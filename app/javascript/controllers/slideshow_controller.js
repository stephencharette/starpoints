import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "slide" ]

  initialize() {
    this.index = 0
    this.showCurrentSlide()
  }

  next(e) {
    e.preventDefault();
    this.index++
    this.showCurrentSlide()
  }

  previous(e) {
    e.preventDefault();
    if(this.index != 0) this.index--
    this.showCurrentSlide()
  }

  showCurrentSlide() {
    this.slideTargets.forEach((element, index) => {
      element.hidden = index !== this.index
    })
  }
}