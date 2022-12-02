import { Controller } from "@hotwired/stimulus"
import Rails from '@rails/ujs';
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      handle: '.grab-handle',
      onEnd: this.end.bind(this)
    })
  }
  
  end(event) {
    let id = event.item.dataset.elementId
    
    let data = new FormData()
    data.append('position', event.newIndex + 1)

    let url = this.data.get('url').replace(/:id/g, id)
    Rails.ajax({
      url: url,
      type: 'PATCH',
      data: data
    })
  }
}
