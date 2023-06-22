import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js";

export default class extends Controller {
  static values = {
    sentences: Array
  }

  connect() {
    const options = {strings: this.sentencesValue, typeSpeed: 35, loop: true};
    new Typed(this.element, options)
  }
}
